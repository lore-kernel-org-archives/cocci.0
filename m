From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 27 May 2015 11:41:14 +0200
Subject: [Cocci] Source code analysis around function name lists
In-Reply-To: <CABBGRWui_CzjQBsCSrUbsUuYhjqtW1uOJ1MzK-ygG58NojhBNw@mail.gmail.com>
References: <CABBGRWtGqhJG4ZUfquga8SY4ASOcAuQP-Oug-gobhS9LMspx9A@mail.gmail.com>
 <alpine.DEB.2.10.1505261912370.2971@hadrien>
 <CABBGRWui_CzjQBsCSrUbsUuYhjqtW1uOJ1MzK-ygG58NojhBNw@mail.gmail.com>
Message-ID: <5565913A.6000009@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> i have a file that contains a list of functions ,

Such an use case was discussed a few times here.


> i want to apply a script to my code when it  detects a function not
> present in my file.

How do you think about to convert the list from your input file to an
other data structure like the following?
* SmPL disjunction
* Alternation in a regular expression for a SmPL constraint

Regards,
Markus
