create database WebformApp

use WebFormApp

create table Genders(
GenderId int primary key identity,
GenderName varchar(50)
)

create table Users(
UserId int primary key identity,
UserName varchar(50),
UserDateOfBirth date,
GenderId int foreign key references Genders(GenderId),
UserPhone varchar(20),
UserAddress varchar(300),
UserPhoto varchar(200),
UserInsertedDate date default getdate(),
UserStatus int default 0
)

Create procedure ProcUsers      
@Action varchar(50)=null,      
@UserId int=0,       
@UserName varchar(50)=null,      
@UserDateOfBirth date=null,      
@GenderId int=0,      
@UserPhone varchar(20)=null,      
@UserAddress varchar(300)=null,      
@UserPhoto varchar(200)=null      
as      
begin      
   if(@Action='GetGender')      
   begin      
      Select * from Genders      
   end    
   else if(@Action='Insert')    
   begin    
      Insert into Users(UserName,UserDateOfBirth,GenderId,UserPhone,UserAddress,UserPhoto)    
   values(@UserName,@UserDateOfBirth,@GenderId,@UserPhone,@UserAddress,@UserPhoto)    
   end    
   else if(@Action='GetUsersList')    
   begin    
      Select u.UserId, u.UserName, convert(varchar(50), u.UserDateOfBirth, 106) as DateOfBirth, g.GenderName, u.UserPhone, u.UserAddress, u.UserPhoto from Users as u     
   inner join Genders as g on u.GenderId=g.GenderId where u.UserStatus=0 
   end
   else if(@Action='Edit')
   begin
      Select UserName,UserDateOfBirth,GenderId,UserPhone,UserAddress,UserPhoto from Users where UserId=@UserId 
   end
   else if(@Action='Delete')
   begin
      Update Users set UserStatus=1 where UserId=@UserId
   end
   else if(@Action='Update')
   begin
      Update Users set UserName=@UserName,UserDateOfBirth=@UserDateOfBirth,GenderId=@GenderId,
	  UserPhone=@UserPhone,UserAddress=@UserAddress,UserPhoto=@UserPhoto where UserId=@UserId
   end
end