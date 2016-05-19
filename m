From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 19 May 2016 22:53:32 +0200 (CEST)
Subject: [Cocci] How to add a field to c structure definition
In-Reply-To: <DC2968D6352D1841BA729D8C06CC9DBB796FD9AB@XSJ-PSEXMBX01.xlnx.xilinx.com>
References: <DC2968D6352D1841BA729D8C06CC9DBB796FD9AB@XSJ-PSEXMBX01.xlnx.xilinx.com>
Message-ID: <alpine.DEB.2.02.1605192249100.2049@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 19 May 2016, Jiaying Liang wrote:

> 
> Hello,
> 
> ?
> 
> I am looking for a way to add a field to a c structure definition.
> 
> ?
> 
> I have this:
> 
> ?
> 
> struct struct_A {
> 
> ?? int a;
> 
> ?? int b;
> 
> };
> 
> ?
> 
> struct struct_B {
> 
> ? int c;
> 
> ? int d;
> 
> };
> 
> ?
> 
> I want to change ?struct struct_A? to:
> 
> struct struct_A {
> 
> ? int a;
> 
> ? int b;
> 
> ? struct struct_B;
> 
> };

Maybe you would like something like this:

@@
@@

struct struct_A {
  ...
+ struct struct_B sb;
};

It could be that you want to add this field not only to the structure that 
has the name struct_A, but to any structure that has a field of type 
struct XXX.  Then you could say:

@@
identifier sa,x;
@@

struct sa {
  ...
  struct XXX x;
  ...
+ struct struct_B sb;
};

Or the structure name might be one that you have stored in a metavariable 
in some other rule r.  So you might have:

@@
identifier r.sa;
@@
  
struct sa {
  ...
+ struct struct_B sb;
};

I hope this help.  Please feel free to write back if you have further 
questions.

julia
