BEGIN{
tcpc=0
udpc=0
}
{
if($1=="d" && $5=="tcp")
	tcpc++;
if($1=="d" && $5=="cbr")
	udpc++;
} 
//for received change to r instead of d
END{
printf("No of packet droped in TCP %d\n",tcpc);
printf("No of packet droped in UDP %d\n",udpc);
}
