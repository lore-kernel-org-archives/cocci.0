From: Felix.Blyakher@Quantum.Com (Felix Blyakher)
Date: Tue, 28 Aug 2018 21:18:59 +0000
Subject: [Cocci] coccinelle to rescue for "C++11 requires a space between
 literal and string macro"
Message-ID: <DM3PR14MB0766042ACA4CECA31C33FF29800A0@DM3PR14MB0766.namprd14.prod.outlook.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello coccinelle experts,

I'm working with the legacy code and with newish gcc 7.3 hit the following warning:

warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]
 #define PADARG64 "0x%016"QUAD"x"
                  ^

where QUAD is a platform dependent string, thus the macro.

The string concatenation works in C OK for this code, though, gcc rightfully complains
about required space and wants it to be:

 #define PADARG64 "0x%016" QUAD "x"

The code like this is sprinkled across huge code base, mostly in printf-like statements,
and some in defines like above to be used in printf-like statements.

I'd like to use coccinelle to change the code globally.
I was trying something like (I know it may have false positive, just need to get something for starter):


@@
Identifier I;
@@

-"I"
+" I "

but spatch complains and doesn't seem is going to do what I need:

""
init_defs_builtins: /usr/lib/coccinelle/standard.h
@rule starting on line 1@
Identifier  I;
@@

-"I"
  >>> " I "



grep tokens
No query
No query
warning: rule starting on line 1: metavariable I not used in the - or context code
""

Any good hint on how to approach this issue.

Thanks,
Felix
The information contained in this transmission may be confidential. Any disclosure, copying, or further distribution of confidential information is not permitted unless such privilege is explicitly granted in writing by Quantum. Quantum reserves the right to have electronic communications, including email and attachments, sent across its networks filtered through security software programs and retain such messages in order to comply with applicable data security and retention requirements. Quantum is not responsible for the proper and complete transmission of the substance of this communication or for any delay in its receipt.
