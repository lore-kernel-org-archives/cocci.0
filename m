From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 16 Jul 2015 07:41:07 +0200
Subject: [Cocci] Deletion of blank lines?
In-Reply-To: <55A60721.5050209@users.sourceforge.net>
References: <55A60721.5050209@users.sourceforge.net>
Message-ID: <55A743F3.6000500@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>  void receiver(...)
>  {
>   ...
> (
> - exit(...);
> |
> - fprintf(...);
> )
>   ...
>  }
> ?
> diff -u -p a/backend/ipp.c b/backend/ipp.c
> --- a/backend/ipp.c
> +++ b/backend/ipp.c
> @@ -3271,8 +3271,6 @@ sigterm_handler(int sig)          /* I - Signal
>  
>    if (tmpfilename[0])
>      unlink(tmpfilename);
> -
> -  exit(1);

I find another detail interesting in this generated patch.
The Coccinelle software suggests here to delete also a blank line
at a specific source code place. I would usually interpret
this SmPL script example in the way that I did not express the removal
of blank lines.

How often do you care if additional source code reformatting should
happen around a specific change (or not)?

Regards,
Markus
