From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 4 Dec 2015 16:42:52 +0100
Subject: [Cocci] Searching with SmPL for missing clean-up settings in
 designated initialisers
In-Reply-To: <alpine.DEB.2.10.1512041543520.2764@hadrien>
References: <56603DC3.8040609@hurleysoftware.com>
 <56608E06.9060003@metafoo.de> <alpine.DEB.2.10.1512032310280.2777@hadrien>
 <20151203234832.GB20409@wotan.suse.de>
 <56619B56.7040508@users.sourceforge.net>
 <alpine.DEB.2.10.1512041543520.2764@hadrien>
Message-ID: <5661B47C.7000600@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> Would this SmPL script variant need any further fine-tuning
>> (or other software extensions)?
> 
> I have no idea what the above does.  The previous proposed variants were
> completely fine.

* I suggest in principle once more to try regular expression out
  for SmPL constraints on data types and corresponding names of member functions.

* The desired function initialisation can be a bit generalised, can't it?

Is such an approach also useful for the requested use case?

Regards,
Markus
