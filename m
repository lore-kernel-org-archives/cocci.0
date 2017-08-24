From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 24 Aug 2017 12:22:51 +0200 (CEST)
Subject: [Cocci] parsing of C code
In-Reply-To: <8fcfa4a0-678a-f8f3-003a-9c953ba36c11@users.sourceforge.net>
References: <alpine.DEB.2.20.1708231104310.3150@hadrien>
 <8fcfa4a0-678a-f8f3-003a-9c953ba36c11@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1708241219540.3187@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 24 Aug 2017, SF Markus Elfring wrote:

> > Actually, I noticed that unfolding macros can sometimes hurt more than it helps.
>
> Would you like to discuss (or explain) involved implementation details
> and configuration parameters any more?

#define FOO(x) BAR(x,+,y)

int foo() __xxx(yyy) {
  FOO(12);
}

int xyz() {
  FOO(15);
}

Parsing of foo fails due to the attribute __xxx(yyy) that Coccinelle is
not able to cope with.  Coccinele hopes that expanding macros will solve
the problem.  Now the code becomes:

#define FOO(x) BAR(x,+,y)

int foo() __xxx(yyy) {
  BAR(12,+,y);
}

int xyz() {
  BAR(15,+,y);
}

Now foo is still unparsable, but xyz is unparsable as well.  It would have
been better off with FOO(15);

julia
