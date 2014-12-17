From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 17 Dec 2014 16:30:40 +0100
Subject: [Cocci] Finding function implementations that call only a
 single function.
In-Reply-To: <54846702.1000505@users.sourceforge.net>
References: <5478F848.1080808@users.sourceforge.net>
 <alpine.DEB.2.02.1412062139570.2256@localhost6.localdomain6>
 <548371FB.9060402@users.sourceforge.net>
 <alpine.DEB.2.02.1412062219530.2256@localhost6.localdomain6>
 <54837413.8000902@users.sourceforge.net>
 <alpine.DEB.2.02.1412062232470.2256@localhost6.localdomain6>
 <5483806D.3070805@users.sourceforge.net>
 <alpine.DEB.2.02.1412062342540.2256@localhost6.localdomain6>
 <5483902E.8060109@users.sourceforge.net>
 <alpine.DEB.2.02.1412070749130.2044@localhost6.localdomain6>
 <54841AB2.6070609@users.sourceforge.net>
 <alpine.DEB.2.02.1412071027040.2044@localhost6.localdomain6>
 <54842A73.4000203@users.sourceforge.net>
 <alpine.DEB.2.02.1412071125130.2044@localhost6.localdomain6>
 <54842E04.9060800@users.sourceforge.net>
 <alpine.DEB.2.02.1412071244240.2044@localhost6.localdo! main6>
 <5484414F.4040900@users.sourceforge.net>
 <alpine.DEB.2.02.1412071337020.2030@localhost6.localdomain6>
 <54846702.1000505@users.sourceforge.net>
Message-ID: <5491A1A0.40809@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I suggest to reconsider this situation once more.

I have looked at my script "list_functions_with_single_function_call5.cocci" again.


> * It can be that I got stuck somehow in this application variant as the
>   number of relevant rules grew.

It seems that I made a bit progress in a better direction.

Now I stumble on the next detail problem if I try to design the needed
SmPL rules for more specific source code.

* How can it be excluded with the semantic patch language to match non-pointer
  data types with the metavariable type "type?"
* Which is the best way to distinguish non-pointer types from pointer data types
  with metavariables?


Regards,
Markus
