From: michelemartone@users.sourceforge.net (Michele Martone)
Date: Fri, 25 May 2018 15:56:29 +0200
Subject: [Cocci] [cocci-bug] coccinelle 1.0.6: OpenMP #pragma directive
 leads to function ignore
In-Reply-To: <20180502131639.GA26874@localhost>
References: <20180426081209.GA7703@localhost>
 <alpine.DEB.2.20.1804260925270.2402@hadrien>
 <20180426102122.GB7703@localhost>
 <alpine.DEB.2.20.1804300842440.2351@hadrien>
 <20180430073930.GA20750@localhost>
 <CA+MoWDrmVnz+cXjepPwWqBPgAoujD9m+1pAMv7JJMFy_2CjNUA@mail.gmail.com>
 <20180502131639.GA26874@localhost>
Message-ID: <20180525135629.GA21989@localhost>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 20180502 at 15:16, Michele Martone wrote:
> On 20180430 at 09:44, Peter Senna Tschudin wrote:
> > ... 
> Dear Peter, thanks for the apt-get based recipe,  
> it worked for me on debian buster with ocaml-4.0.5.
> 
> Dear Julia, thanks for the pragma patch which will
> enable coccinelle to support OpenMP-enabled listings
> too (I just tested it on the above setup) :-)
> 
> Michele

Dear Julia,

I have another similar minimal test spatch case failing, attached.
It seems like using
 #pragma omp parallel for private(I)
breaks the semantic patch, while having 
 #pragma omp parallel for 
is still ok.
Please see attachment.

I'm using self-built ocaml (e407ecf11 2018-05-25)
and coccinelle (a4532f08 2018-05-17).

would be very useful to have full #pragma resilience!

Michele
-------------- next part --------------
// seems like this example breaks:
// spatch version 1.0.6-00440-ga4532f08 compiled with OCaml version 4.08.0+dev0-2018-04-09
// (a4532f08 2018-05-17)

/*
pragma_ignored_again.cocci:

@@
symbol A,I,J;
@@

-A[I]
+A[J]
*/
void f(void)
{
	int*A=NULL,I=0;
// pragma presence breaks semantic patch (remote private(i) to 'fix' it)
// comment it to have A[I] -> A[J]
#pragma omp parallel for private(I)
	A[I]++;
}
