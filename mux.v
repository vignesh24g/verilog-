module mux(win, one,two, select); 
	input one,two,select;
	output win;
	assign win=(select)? one: two;
 endmodule
 
 module muxteam(a,b,c,d,win1,win2,winner);
	input a,b,c,d;
	output win1,win2,winner;
	
	mux m1(a,b,win1);
	mux m2(c,d,win2);
	
	mux m3(win1,win2,winner);
	
end module