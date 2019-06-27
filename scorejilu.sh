#!/bin/sh

colour()
{
case $1 in
black_white)
	echo -e "\033[40;37m"
;;
black_green)
	echo -e "\33[40;32m"
;;
black_cyan)
	echo -e "\033[40;36m"
;;
red_yellow)
	echo -e "\033[41;33m"
;;
yellow_blue)
	echo -e "\033[43;34m"
;;
esac
}

#search
search()
{
colour black_white
clear
echo -e "Please Enter Name >>>\c"
read NAME
if [! -f ./record]; then
	echo "You must have some scores before you can search!"
	sleep 2
	clear
	return
fi 
if [ -z "$NAME" ]; then
	echo "You didn't enter a name!"
	echo -e "Please Enter Name >>>\c"
	read NAME
fi
grep -i "$NAME" ./record 2> /dev/null

case "$?" in
	1) echo "NAME not in record"
;;
	2) echo "you didn't enter a name to search ";
	  sleep 2;
 	  search;;
	esac
}

#add function
add()
{
clear
echo "Enter name and score of a record"
echo -e "\c"
if [ ! -f ./record ];then
touch record
fi
read NEWNAME
echo "$NEWNAME" >./record
sort -o ./record ./record
}

#delete
delete()
{
clear
echo -e "Please enter name>>>c"
read NAME

if [ ! -f ./record ];then
echo "this name is not in record"
else
cp record record.bak
rm -f record
grep -v "$NAME" ./record.bak > record
rm -f record.bak
fi
}

#xian shi ji lu
displar()
{
colour black_white
more ./record
}

edit()
{
vi ./record
}

help()
{
clear
colour black_cyan
echo "This is a student's record program by UNIX shell language!"
}

quit()
{
clear
colour black_white
exit
}

clear
while true
do colour red_yellow
	echo "************************************************************"
	echo "*                    STUDENT'S RECORD MENU                 *"
	echo "************************************************************"
	colour yellow_blue
	echo "############################################################"
	echo "#                  1:SEARCH A RECORD                       #"
	echo "#                  2:ADD A RECORD                          #"
	echo "#                  3:DELETE A RECODE                       #"
	echo "#                  4:DISPLAY ALL RECORDS                   #"
	echo "#                  5:EDIT RECODE WITH VI                   #"
	echo "#                  H:HELP Screen                           #"
	echo "#                  Q:Exit Program                          #"
colour black_green
echo -e -n "\tPlease Enter Your Choice [1,2,3,4,5,H,Q]:\c"
read CHOICE

case $CHOICE in
	1)search;;
	2)add;clear;;
	3)delete;clear;;
	4)display;clear;;
	5)edit:clear;;
	H|h)help;;
	Q|q)quit;;
	*)echo "INvalid CHoice!";
	sleep 2;
	clear;;
esac
done
