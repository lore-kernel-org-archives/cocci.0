From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 5 May 2016 13:10:20 +0200
Subject: [Cocci] [RFC 0/2] coccinelle: extend test coverage
In-Reply-To: <1462426254-22633-1-git-send-email-mcgrof@kernel.org>
References: <1462426254-22633-1-git-send-email-mcgrof@kernel.org>
Message-ID: <f862ba3d-f3f2-6e58-ad51-7e1840c48af3@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I wanted to extend tests coverage for coccinelle but noticed
> that tests are limited to single c file, these are attached
> to respective .res files, but this also means that you have
> a direct relationship and requirement between tests from
> a single C file and a respective cocci file.

Do you imagine to measure test coverage with any advanced techniques?


> To go wild we want to be able to support really complex
> types of examples.

Is there any kind of target conflict between nice software
demonstrations and the desire for better test procedures?


> We can easily take advantage of this to extend Coccinelle test cases
> way beyond a single C file, but to more complex real life
> style projects.

How much would you like to improve the automatic checking
of generated patches?

Regards,
Markus
