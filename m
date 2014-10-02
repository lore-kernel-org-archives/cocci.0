From: chrubis@suse.cz (Cyril Hrubis)
Date: Thu, 2 Oct 2014 15:42:34 +0200
Subject: [Cocci] string parameter concatenation
In-Reply-To: <alpine.DEB.2.02.1410021536130.2101@localhost6.localdomain6>
References: <20141001130215.GB4701@rei.suse.cz>
 <542D4AA2.6060407@users.sourceforge.net>
 <20141002130716.GA3635@rei.suse.cz>
 <alpine.DEB.2.02.1410021536130.2101@localhost6.localdomain6>
Message-ID: <20141002134234.GA4544@rei.suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi!
> It is not actually necessary to remove and add back L.  You could write:
> 
> - tst_resm
> + txt_brkm
>    (C,
> +   NULL,
>     L);
> - tst_exit();

Ah, you are right. I should really stop thinking in terms of lines of
code and focus more on the tokens lines are composed of.

> However, it is useful to have the bug reports.

I'm a proffesional QA and therefore I'm very skilled in breaking things :).

-- 
Cyril Hrubis
chrubis at suse.cz
