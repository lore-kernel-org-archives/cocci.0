From: eliseomarmol@gmail.com (=?utf-8?Q?Eliseo_Mart=C3=ADnez?=)
Date: Sun, 21 Dec 2014 14:12:53 +0100
Subject: [Cocci] Change function invocations argument
In-Reply-To: <5496C331.70807@users.sourceforge.net>
References: <F51E5D4A-BD27-4192-95B7-2164D25A4380@gmail.com>
 <alpine.DEB.2.02.1412202131540.2098@localhost6.localdomain6>
 <254A1CAA-2FA6-4546-91BD-5E0C449C7F94@gmail.com>
 <alpine.DEB.2.02.1412202147460.2098@localhost6.localdomain6>
 <D2F6C23B-F5FF-41DE-86B3-8C7210DA61BD@gmail.com>
 <alpine.DEB.2.02.1412211157000.2068@localhost6.localdomain6>
 <2BD158D5-96AC-4BEC-81B9-F07A54C7BEEB@gmail.com>
 <5496B54D.8050501@users.sourceforge.net>
 <alpine.DEB.2.02.1412211302450.2068@localhost6.localdomain6>
 <6C06025D-6720-4BBD-9D44-75802D8A5B53@gmail.com>
 <5496C1D3.9000007@users.sourceforge.net>
 <39F30C32-5E8F-4FE9-B6C5-4C0BEA1955C4@gmail.com>
 <5496C331.70807@users.sourceforge.net>
Message-ID: <FD60F271-AC55-439C-A6D0-56186C3CD9F1@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I?m afraid I still don?t get you.
What I?m asking is:

Given that coccinelle understands c structure, and knows about common isomorphisms, is there an easy way so that I can instruct it to analyze every expression in my source code, and remove parentheses at every place they?re not needed? By not needed, I mean that the c expression meaning (taking into account operator precedence and the like) is the same with and without parentheses.

I?m working with a 200000 LOC codebase. So, if there?s no dependable way to do this (without false positives and the like), then I?d have to manually review every change. Feasibility of that depends on how many instances are found, which I cannot now in advance. If they are too many and I have to review them manually, then this is probably not worth the trouble.

Regards, 
Eliseo.

> On 21 Dec 2014, at 13:55, SF Markus Elfring <elfring@users.sourceforge.net> wrote:
> 
>> Sorry, don?t understand your question?
> 
> I guess that you need to become more specific in your wording / programming
> about the source code places where parentheses are really unnecessary.
> 
> How many efforts would you like to invest to avoid false positives and other
> unwanted software changes?
> 
> Regards,
> Markus
