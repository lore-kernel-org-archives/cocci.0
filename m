From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 22 Jan 2015 10:50:55 +0100
Subject: [Cocci] Run time differences between SmPL disjunctions and
 regular expressions (in constraints)
In-Reply-To: <alpine.DEB.2.10.1501221032270.4079@hadrien>
References: <D59A6A6F-9D60-44DE-9B6C-8B615B776EA8@gmail.com>
 <54BFD099.8030002@users.sourceforge.net>
 <F6392E9E-0D22-4398-8173-DD84FFEBAB98@gmail.com>
 <alpine.DEB.2.10.1501212342170.2599@hadrien>
 <54C0B4DF.9060203@users.sourceforge.net>
 <alpine.DEB.2.10.1501221032270.4079@hadrien>
Message-ID: <54C0C7FF.2060007@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> Would anybody like to compare the concrete run time consequences for the
>> specification of a specific function name list in semantic patch scripts?
>> * Alternation for regular expressions in SmPL constraints
>> * SmPL disjunction variant
> Since you care so much about performance, why not do it yourself?

There are two reasons.
1. I would like to avoid the efforts for development of a representative
   test case for such a speed comparison.

2. I am using regular expressions in constraints (for my other source
code analysis)
   because of functionality that is not directly provided by the semantic
   patch language so far.
   Can it be that the regex syntax is more succinct for specific use cases?

Regards,
Markus
