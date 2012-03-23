# encoding: UTF-8

# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#  degree1            :string(255)
#  year               :integer
#  likes              :text
#  linkedin           :string(255)
#  abroad             :text
#  work               :text
#  admin              :boolean         default(FALSE)
#  degree2            :string(255)
#

require 'digest'

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :degree1, :degree2, :year, :likes, :linkedin, :abroad, :work
  attr_accessor :password

  has_many :posts

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, :presence=>true, :length=>{:maximum=>50}
  validates :email, :presence=>true, :format=>{:with=>email_regex}, :uniqueness=>{:case_sensitive=>false}
  # validates_inclusion_of :degree, :in=> %w(Teleco+Mates Teleco+Informatica), :message => "Nomes saccepten aquestes titulacions"


  #Automatically create the virtual attribute 'password_confirmation'
  validates :password, :presence=>true,:confirmation=>true,:length=>{:within=>6..40}

  before_save :encrypt_password


  def has_password?(submitted_password)
    encrypted_password==encrypt(submitted_password)
  end

  def self.authenticate(email,submitted_password)
    user=find_by_email(email)
	return nil if user.nil?
	return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id,cookie_salt)
    user=find_by_id(id)
	(user && user.salt==cookie_salt) ? user : nil
  end

  def signed_in?
    !current_user.nil?
  end

  
  def self.search_year(search)
    years=search.split('-') 
    if years.length==1 && years.first.to_i.between?(2003,Time.now.year) # only one year specified ALSO, SHOULD IT BE CURRENT YEAR?
       [years.first.to_i,years.first.to_i]
    elsif years.length==2 && years.first.to_i.between?(2003,Time.now.year) && years.second.to_i.between?(2003,Time.now.year) && years.second.to_i>years.first.to_i
       [years.first.to_i,years.second.to_i]
    else
       nil
    end
  end

  def self.search_degree(search)
    case search.downcase
      when "telecos","telecomunicacions","telecomunicaciones"
         "Telecomunicacions"
      when "mates","matematiques","matemàtiques","matematicas","matemáticas"
         "Matemàtiques"
      when "informatica","informàtica","informática"
         "Informàtica"
      when "camins","caminos"
         "Camins"
      when "industrials","indus","industriales"
         "Industrials"
      else
         nil   
    end
  end
  
  def self.search_degree_mote(search)
    case search #busca per 'motes'
      when "telecomat","telecomates"
        ["Telecomunicacions","Matemàtiques"]
      when "infomates","infomat"
        ["Informàtica","Matemàtiques"]
    end #no se m'acudeixen més!    
  end

  def self.search(search)
    if search

       search_cond=''
       search_param={}

       parts=search.split(/[ +]/).compact #without compact it doesn't work, has some nil elements... why??

       parts.each do |search_component|
         search_cond+="AND" unless search_cond.empty?
         if !(years=search_year(search_component)).nil?
           search_cond+='(year BETWEEN :year_first AND :year_last)'
           search_param[:year_first]=years.first
           search_param[:year_last]=years.second
         elsif !(degrees=search_degree_mote(search_component)).nil?
           search_cond+='((degree1 = :degree1 AND degree2 = :degree2) OR (degree1 = :degree2 AND degree2 = :degree1))'
           search_param[:degree1]=degrees.first
           search_param[:degree2]=degrees.second
         elsif !(degree=search_degree(search_component)).nil?
           if search_param[:degree1].nil?
              search_cond+='(degree1 =:degree1 OR degree2=:degree1)'
              search_param[:degree1]=degree
           elsif search_param[:degree2].nil?
              search_cond+='(degree1 =:degree2 OR degree2=:degree2)'
              search_param[:degree2]=degree
           end
         else #interpreto que és el nom d'una persona (o, més endavant, d'una empresa)
           search_cond+='(LOWER(name) LIKE :name)'
           search_param[:name]="%#{search_component.downcase}%"
         end
       end
       
       where(search_cond,search_param)

    else
      find(:all)
    end
  end

  private
    def encrypt_password
      self.salt=make_salt unless has_password?(password)
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end
