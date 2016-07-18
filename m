From: wagle@mac.com (Perry Wagle)
Date: Mon, 18 Jul 2016 16:39:40 -0700
Subject: [Cocci] Support for more programming languages?
In-Reply-To: <2c0fb3b6-966a-4d9a-9947-2d0701e4eb66@users.sourceforge.net>
References: <009C7972-C7EB-4B7F-ABC5-A1C0C1CA5797@mac.com>
 <76bf1017-d629-d44a-5493-0dcccbbfa65b@users.sourceforge.net>
 <469DA7F6-6AC1-4040-AB2A-6A1DF1CDDF9D@mac.com>
 <2c0fb3b6-966a-4d9a-9947-2d0701e4eb66@users.sourceforge.net>
Message-ID: <B86E11CD-210D-4C8F-AEA6-D92276C01162@mac.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


> On Jul 18, 2016, at 8:20 AM, SF Markus Elfring <elfring@users.sourceforge.net> wrote:
> 
>> LLVM has been C++ from the beginning, and GCC is being rewritten in C++,
> 
> I guess that there are still various software development challenges evolving.
> 
> 
>> though maybe with enough of a C flavor to be amenable to Coccinelle.
> 
> How do you think about common properties in the discussed programming
> language mixture?
> 
> Do you find a feature request like "Exclusion of unsupported source code parts"
> interesting for further consideration?
> https://github.com/coccinelle/coccinelle/issues/20

I?m uncomfortable with excluding anything.  When I did StackGuard GCC compiler(three times, yeesh), I used it to recompile all the code that gcc compiles in the Redhat distribution.  Every single procedure (except one).  The result was both fast and virtually bug free (one bug).  This was proof of concept.
