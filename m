From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 19 Nov 2014 11:45:42 +0300
Subject: [Cocci] [PATCH 1/1] net: xfrm: Deletion of an unnecessary check
 before the function call "ipcomp_free_tfms"
In-Reply-To: <546BAFF5.5020603@users.sourceforge.net>
References: <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <546BAFF5.5020603@users.sourceforge.net>
Message-ID: <20141119084542.GK4905@mwanda>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Nov 18, 2014 at 09:45:41PM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 18 Nov 2014 21:41:26 +0100
> 
> The ipcomp_free_tfms() function tests whether its argument is NULL and then
> returns immediately. Thus the test around the call is not needed.
> 

It doesn't though...

regards,
dan carpenter
