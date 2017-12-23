From: knut.omang@oracle.com (Knut Omang)
Date: Sat, 23 Dec 2017 12:22:28 +0100
Subject: [Cocci]
 =?utf-8?q?=5BPATCH_v2_2/5=5D_Documentation=3A_Further_cha?=
 =?utf-8?b?bGxlbmdlcyBhcm91bmQg4oCccnVuY2hlY2tz4oCd?=
In-Reply-To: <67ce13bc-6022-9110-6d14-45ca22f91492@users.sourceforge.net>
References: <7bd67f980fdf33031c54955f7e04b435c267886e.1513430008.git-series.knut.omang@oracle.com>
 <67ce13bc-6022-9110-6d14-45ca22f91492@users.sourceforge.net>
Message-ID: <1514028148.31439.464.camel@oracle.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Marcus,

Thanks for all the useful enhancement feedback, I plan to look through these
in detail when I prepare for v3 - right now family has to get priority.

My initial thoughts from a quick glance is that these are good points that will improve
the docs and functionality, I also have a long list of ideas myself, but I am a bit
reluctant to put significantly more work into this until I have some guarantee that any of
it will be accepted. Maybe we can save some of it for an update patch later?

Thanks,
Knut

On Sat, 2017-12-23 at 11:10 +0100, SF Markus Elfring wrote:
> > +The ``typedef`` command adds ``NAME`` and associates it with the given
> > +regular expression. This expression is used to match against standard error
> > +output from the checker and ``NAME`` can be used as a new named check that
> > +runchecks understands and that can be used with checker supported names
> > +below to selectively suppress that particular set of warning or error
> > +messages.
> 
> I would like to clarify further software development concerns.
> https://github.com/torvalds/linux/compare/master...knuto:runchecks#commit_comments_bucke
> t
> 
> 1. Would an other identifier be more appropriate for this use case?
> 
> 2. Which flavour of regular expressions would you like to use here?
> 
> 3. Is the ?named check? a data filter?
> 
> 4. How do you think about to share any more experiences from previous
>    applications of similar approaches?
> 
> 5. I imagine that corresponding regexes can become complicated.
>    Would you like to develop a pattern library then?
> 
> 6. It can happen that messages which are provided by special programs are
>    so complex that scripts for higher level programming languages would
>    be applied.
> 
> 7. How would you like to iterate through several messages from an error log?
> 
> 8. Will an include statement be needed so that configuration scripts can be
>    better combined?
> 
> 9. Does the suggested script language need a structured format description
>    as extended Backus-Naur form (ISO/IEC 14977)?
> 
> Regards,
> Markus
