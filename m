From: wagle@mac.com (Perry Wagle)
Date: Sun, 17 Jul 2016 17:43:50 -0700
Subject: [Cocci] Support for more programming languages?
In-Reply-To: <76bf1017-d629-d44a-5493-0dcccbbfa65b@users.sourceforge.net>
References: <009C7972-C7EB-4B7F-ABC5-A1C0C1CA5797@mac.com>
 <76bf1017-d629-d44a-5493-0dcccbbfa65b@users.sourceforge.net>
Message-ID: <469DA7F6-6AC1-4040-AB2A-6A1DF1CDDF9D@mac.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


> On Jul 16, 2016, at 11:48 PM, SF Markus Elfring <elfring@users.sourceforge.net> wrote:
> 
>> The main problem is that firefox is written in a variety of programming languages.
> 
> https://www.quora.com/What-programming-languages-are-web-browsers-like-Google-Chrome-Opera-and-Mozilla-Firefox-written-in
> 
> 
>> How hard would it be to retarget Coccinelle to those languages?
> 
> The Coccinelle software is concentrating on source code transformations
> for the programming language "C" so far.
> For which languages do you look for improvements finally?
> 
> * How would you like to improve tools for context-dependant languages like "C++??

Well, to use a general term, I want to comprehend LLVM and GCC for various reasons.  LLVM has been C++ from the beginning, and GCC is being rewritten in C++, though maybe with enough of a C flavor to be amenable to Coccinelle.

> * How ambitious are you to support further software development around such areas?

Julia was underwhelmed, but I?m still looking for a use for Coccinelle just in case.  See my response to her response. 


> Regards,
> Markus
