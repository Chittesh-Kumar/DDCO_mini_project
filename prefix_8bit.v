module pg(input wire a,b, output wire p,g);
	xor2 x0(a,b,p);
	and2 a0(a,b,g);
endmodule

module carry(input wire pi,pi_p,gi,gi_p, output wire p, g);
wire t;
	and2 a1(pi,pi_p,p);
	and2 a2(pi,gi_p,t);
	or2 o2(t,gi,g);
endmodule

module sum(input wire a, b, cin_p, output wire s);
	xor3 x3(a,b,cin_p,s);
endmodule

module prefix_add8(input wire [7:0]a,b,output wire [7:0] sum);
wire p[7:0],g[7:0];
wire cp[7:0],cg[7:0];
wire cp21,cg21,cp43,cg43,cp54,cg54,cp65,cg65,cp64,cg64;

	pg p_0(a[0],b[0],p[0],g[0]);
	pg p_1(a[1],b[1],p[1],g[1]);
	pg p_2(a[2],b[2],p[2],g[2]);
	pg p_3(a[3],b[3],p[3],g[3]);
	pg p_4(a[4],b[4],p[4],g[4]);
	pg p_5(a[5],b[5],p[5],g[5]);
	pg p_6(a[6],b[6],p[6],g[6]);
	pg p_7(a[7],b[7],p[7],g[7]);

	assign cp[0] = 1'b0;
	assign cg[0] = 1'b0;

	carry c1(p[0],0,g[0],0,cp[1],cg[1]);
	carry c3_0(p[2],p[1],g[2],g[1],cp21,cg21);
	carry c5_0(p[4],p[3],g[4],g[3],cp43,cg43);
	carry c7_0(p[6],p[5],g[6],g[5],cp65,cg65);

	carry c2(p[1],cp[1],g[1],cg[1],cp[2],cg[2]);
	carry c3_1(cp21,cp[1],cg21,cg[1],cp[3],cg[3]);
	carry c6_0(p[5],cp43,g[5],cg43,cp54,cg54);
	carry c7_1(cp65,cp43,cg65,cg43,cp64,cg64);

	carry c4(p[3],cp[3],g[3],cg[3],cp[4],cg[4]);
	carry c5_1(cp43,cp[3],cg43,cg[3],cp[5],cg[5]);
	carry c6_1(cp54,cp[3],cg54,cg[3],cp[6],cg[6]);
	carry c7_2(cp64,cp[3],cg64,cg[3],cp[7],cg[7]);

	sum s0(a[0],b[0],0,sum[0]);
	sum s1(a[1],b[1],cg[1],sum[1]);
	sum s2(a[2],b[2],cg[2],sum[2]);
	sum s3(a[3],b[3],cg[3],sum[3]);
	sum s4(a[4],b[4],cg[4],sum[4]);
	sum s5(a[5],b[5],cg[5],sum[5]);
	sum s6(a[6],b[6],cg[6],sum[6]);
	sum s7(a[7],b[7],cg[7],sum[7]);
endmodule