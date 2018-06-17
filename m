From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 17 Jun 2018 19:09:11 +0200
Subject: [Cocci] Searching for constants between shift operators with SmPL
Message-ID: <5e128120-0168-397f-e2fb-9ffd59ec3683@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

The following script for the semantic patch language can mark a bit of source
code also in a corresponding example.


@display@
constant C;
expression A, B;
identifier X;
type T;
@@
 T X = A
 <<
*C
 <<
 B;


int main(void)
{
unsigned int a = 2, b = 4;
unsigned long c = a << 2 << b;
}


1. I get the error message ?minus: parse error? after the addition of
   a SmPL ellipsis behind the metavariable ?B?.

2. I have observed that no source code is found if I omit the metavariables ?T?
   and ?X? (omission of the assignment target) in a SmPL script variant.


How do you think about to clarify these software situations any more?

Regards,
Markus
