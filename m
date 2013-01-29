From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 29 Jan 2013 22:42:19 +0100 (CET)
Subject: [Cocci] Prepending '*' to an expression (Was: [PATCH V2]
 scripts/coccinelle/misc/memcpy-assign.cocci: Replace memcpy with struct
 assignment)
In-Reply-To: <5108415F.1020603@redhat.com>
References: <1358978790-2990-1-git-send-email-peter.senna@gmail.com>
 <510173B3.9090002@redhat.com>
 <CA+MoWDq-Ne6GYUHe-OtrF1MvUv1ou+xPZZfid+TvndLgbpF5Dg@mail.gmail.com>
 <51059238.1090009@redhat.com> <alpine.DEB.2.02.1301282303220.2060@hadrien>
 <5108415F.1020603@redhat.com>
Message-ID: <alpine.DEB.2.02.1301292240410.2023@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 29 Jan 2013, Michael Stefaniuc wrote:

> Hello Julia,
> 
> On 01/28/2013 11:04 PM, Julia Lawall wrote:
> > On Sun, 27 Jan 2013, Michael Stefaniuc wrote:
> > 
> >> Hello Peter,
> >>
> >> On 01/26/2013 02:28 AM, Peter Senna Tschudin wrote:
> >>> Thank you for testing.
> >>>
> >>> I made changes on the semantic patch. I believe it fixed the problem.
> >>> Can you test it?
> >> while it does fix the issue it makes the cocci script less readable and
> >> works only in that particular case. Not sure it is worth the effort as
> >> the bad generated patch can be trivially detected and easily fixed
> >> manually. My email was more of a bug report / feature request for
> >> coccinelle than an improvement request to the script.
> >>
> >> Though I've noticed an other issue with the script: Any reason you use
> >> "Options: --no-includes"? While it does speed up things it misses quite
> >> a few cases as a lot of types are defined in the headers.
> > 
> > I think it should be --all-includes or even --recursive-includes
> no clue what the policy in the Kernel is but --recursive-includes is
> quite heavy handed as a default. I have one --recursive-includes still
> running for Wine and it accumulated until now over 1126 CPU minutes
> (Intel i5 mobile CPU with 2.4 GHz). It found 5 more cases while
> --no-includes found 11 and --local-includes additional 32. The
> --local-includes finished in less than 30 minutes (didn't time it exactly).

OK.  It depends on how much type information is needed.  A compromise 
could be to make a rule without type information that makes clear that one 
has less confidence in the result.  Then the user could just go look up 
the type information if needed.

-all_includes could be good then.  It only includes what is specifically 
referenced in the current file.

julia
