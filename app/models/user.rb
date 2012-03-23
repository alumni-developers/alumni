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

  def self.classifica_degree(degree)
    case degree.downcase
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
  
  def self.search_degree(search)
    titulacions=search.split('+') 

    case titulacions.first #busca per 'motes'
      when "telecomat","telecomates"
        return ["Telecomunicacions","Matemàtiques"]
      when "infomates","infomat"
        return ["Informàtica","Matemàtiques"]
    end #no se m'acudeixen més!
    
    if titulacions.length==1 
        return [check=classifica_degree(titulacions.first)] unless check.nil?
    else
        return !(check=[classifica_degree(titulacions.first),classifica_degree(titulacions.second)]).include?(nil) ? check : nil    
    end
    
    return nil
  end

  def self.search(search)
    if search

       search.sub(/ i /,'+') #Per poder admetre telecos i mates ==> telecos+mates
       search_cond=''
       search_param={}
       parts=search.split(' ')
       parts.each do |search_component|
         if !(years=search_year(search_component)).nil?
           search_cond+='(year BETWEEN :year_first AND :year_last)'
           search_param[:year_first]=years.first
           search_param[:year_last]=years.second
         elsif !(degrees=search_degree(search_component)).nil?
           search_cond+='AND((degree1 = :degree1 AND degree2 = :degree2) OR (degree1 = :degree2 AND degree2 = :degree1))'
           search_param[:degree1]=degrees.first
           search_param[:degree2]=degrees.second
         end
       end
       
       where(search_cond,search_param)

#       where('year BETWEEN ? AND ?',*search_year(search))
#
#
        #might search by degree
       #only one degree specified
 #          titulacio2=titulacio1=classifica_degree(titulacions.first)        
#	   where("degree1 = :degree1 OR degree2 = :degree2",{:degree1=>titulacio1,:degree2=>titulacio2}) #search by degree
 #       elsif titulacions.length==2
  #         titulacio1=classifica_degree(titulacions.first)
   #        titulacio2=classifica_degree(titulacions.second)
    #       where("(degree1 = :degree1 AND degree2 = :degree2) OR (degree1 = :degree2 AND degree2 = :degree1)",
     #           {:degree1=>titulacio1,:degree2=>titulacio2}) #search by degree
     #      where('LOWER(degree1) LIKE ?', "%{titulacio1}%")     
# 	   where('LOWER(degree1) LIKE ?', "%{titulacions.first.downcase}%")       
#          where('LOWER(name) LIKE ?', "%{search.downcase}%") falta coixinet!
#        end
#      end
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
