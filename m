From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 07 Dec 2014 15:41:06 +0100
Subject: [Cocci] Finding function implementations that call only a
 single function.
In-Reply-To: <alpine.DEB.2.02.1412071337020.2030@localhost6.localdomain6>
References: <5478F848.1080808@users.sourceforge.net>
 <548358DE.6020409@users.sourceforge.net>
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
Message-ID: <54846702.1000505@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Of course, you can also tell from the returns, or lack there of, in the 
> function whether the function has void return type as well.

This approach is exactly the kind of SmPL filter design I tried out
with the script "list_functions_with_single_function_call5-no_db.cocci"
for example.

Unfortunately, I frightened and annoyed you with that SmPL rule collection
to some degree.

I suggest to reconsider this situation once more.
* It can be that I got stuck somehow in this application variant as the
  number of relevant rules grew.

* But is it also possible to compute the number of required rules from
  factors in this way for a logically correct version?
  return_type_detection x pointer_usage x static_determination x ...

Regards,
Markus
