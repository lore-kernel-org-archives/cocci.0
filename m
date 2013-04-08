From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 08 Apr 2013 23:14:45 +0200
Subject: [Cocci] Handling of omitted data type specification?
In-Reply-To: <alpine.DEB.2.02.1304081655220.1963@hadrien>
References: <mailman.1.1364983201.25969.cocci@systeme.lip6.fr>
 <1365431375.3314.42.camel@zamolxis.metaware.tm.fr>
 <alpine.DEB.2.02.1304081655220.1963@hadrien>
Message-ID: <51633345.6060103@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> In the previous fix that I made, I just caused the missing type,
> which was hidden under a macro, to make the match fail.

How do you think about to make this detail configurable?


> In this case, though perhaps you would prefer T to be bound to int?

Does the C programming language specify that integers are used as the default
data type (or if modifiers are used)?
http://stackoverflow.com/questions/2099830/unsigned-keyword-in-c#2099873
https://www.cs50.net/resources/cppreference.com/data_types.html
http://en.cppreference.com/w/cpp/language/types


> That might cause some problemes, though, because it is not a real "int"
> in the source code...

Does the semantic patch language support to filter for omitted data types?

Would you like to distinguish the use case if this item was just forgotten or
intentionally omitted?

Regards,
Markus
