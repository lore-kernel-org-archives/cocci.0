From: lambert.quentin@gmail.com (Quentin Lambert)
Date: Fri, 19 Jun 2015 21:13:34 +0200
Subject: [Cocci] release: 1.0.1: Checking installation dependencies
In-Reply-To: <55845D5F.6010408@users.sourceforge.net>
References: <alpine.DEB.2.10.1506180654120.2663@hadrien>
 <55845D5F.6010408@users.sourceforge.net>
Message-ID: <558469DE.9030906@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On 19/06/2015 20:20, SF Markus Elfring wrote:
>> Some further performance improvements could be possible.
> I have successfully built this release also on my system a moment ago.
> http://coccinelle.lip6.fr/distrib/coccinelle-1.0.1.tgz
>
> The installation worked also as expected at a first look.
> But I wonder about the following error message at the moment.
>
> elfring at Sonne:~> spatch -version
> There is no standard.iso in /home/elfring.
> Are you sure you run a properly installed version of spatch ?\nNo 'spatch' nor 'spatch.opt' found in /home/elfring
>
>
> If I reinstall a previous software release, I get an expected display instead.
>
> spatch version 1.0.0-rc24 with Python support and with PCRE support
>
>
> How should such a surprise be fixed?
Hi,
this is a bug,
can you send me a copy of the bash script at the address returned by 
"which spatch"

Regards,

Quentin
>
> Regards,
> Markus
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
