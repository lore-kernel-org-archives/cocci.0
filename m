From: Daniel.Lundqvist@pfsw.com (Daniel Lundqvist)
Date: Fri, 11 Mar 2016 07:04:08 +0000
Subject: [Cocci] Remove remove unnecessary parentheses.
Message-ID: <A448EE81-8601-4EEA-BBA3-1EED4927F338@pfsw.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

I just got started with Coccinelle and tried to write a few simple transformations for our code base. The first one works fine:

@@
expression E;
constant C;
@@

- BIT_TEST(E, C)
+ (E & C)


This may introduce a pair of parentheses where it is not necessary, depending on where the macro is used, example:

assert(BIT_TEST(flags, VERBOSE));

Would be:

assert((flags & VERBOSE));

I then tried the perhaps obvious transformation:

@disable paren@
expression E;
@@

-((E))
+(E)

But that does not work, obvious to some perhaps. How can I write what I want? Any pointers to allow me better understand why it does not work?


Thanks in advance.

-- 
daniel
