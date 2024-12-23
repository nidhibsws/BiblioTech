#!/bin/sh

MainMenu()
{
while true;
do
clear
echo "================================================================="
echo "| BiblioTech Database Management System|"
echo "| Main Menu - Select Desired Operation(s):|"
echo "| <CTRL-Z Anytime to Enter Interactive CMD Prompt>|"
echo "-----------------------------------------------------------------"
echo "  M) View Manual"
echo " "
echo " 1) Drop Tables"
echo " 2) Create Tables"
echo " 3) Populate Tables"
echo " 4) Query Tables"
echo " 5) View Tables"
echo " "
echo " X) Force/Stop/Kill Oracle DB"
echo " "
echo " E) End/Exit"
echo "Choose: "
read CHOICE
if [ "$CHOICE" = "0" ]
then
echo "Nothing Here"
elif [ "$CHOICE" = "1" ]
then
bash drop_tables.sh
read -p "Press [Enter] to continue"
elif [ "$CHOICE" = "2" ]
then
bash create_tables.sh
read -p "Press [Enter] to continue"
elif [ "$CHOICE" = "3" ]
then
bash populate_tables.sh
read -p "Press [Enter] to continue"
elif [ "$CHOICE" = "4" ]
then
bash queries.sh
read -p "Press [Enter] to continue"
elif [ "$CHOICE" = "5" ]
then
bash view_table.sh
read -p "Press [Enter] to continue"
elif [ "$CHOICE" = "E" ]
then
exit
fi
done
}

ProgramStart()
{
StartMessage
while [ 1 ]
do
        MainMenu
done
}
ProgramStart
