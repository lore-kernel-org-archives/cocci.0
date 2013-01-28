From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 28 Jan 2013 23:04:38 +0100 (CET)
Subject: [Cocci] Prepending '*' to an expression (Was: [PATCH V2]
 scripts/coccinelle/misc/memcpy-assign.cocci: Replace memcpy with struct
 assignment)
In-Reply-To: <51059238.1090009@redhat.com>
References: <1358978790-2990-1-git-send-email-peter.senna@gmail.com>
 <510173B3.9090002@redhat.com>
 <CA+MoWDq-Ne6GYUHe-OtrF1MvUv1ou+xPZZfid+TvndLgbpF5Dg@mail.gmail.com>
 <51059238.1090009@redhat.com>
Message-ID: <alpine.DEB.2.02.1301282303220.2060@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, 27 Jan 2013, Michael Stefaniuc wrote:

> Hello Peter,
>
> On 01/26/2013 02:28 AM, Peter Senna Tschudin wrote:
> > Thank you for testing.
> >
> > I made changes on the semantic patch. I believe it fixed the problem.
> > Can you test it?
> while it does fix the issue it makes the cocci script less readable and
> works only in that particular case. Not sure it is worth the effort as
> the bad generated patch can be trivially detected and easily fixed
> manually. My email was more of a bug report / feature request for
> coccinelle than an improvement request to the script.
>
> Though I've noticed an other issue with the script: Any reason you use
> "Options: --no-includes"? While it does speed up things it misses quite
> a few cases as a lot of types are defined in the headers.

I think it should be --all-includes or even --recursive-includes

julia.

>
> bye
> 	michael
>
> > On Thu, Jan 24, 2013 at 3:47 PM, Michael Stefaniuc <mstefani@redhat.com> wrote:
> >> Hello,
> >>
> >> On 01/23/2013 11:06 PM, Peter Senna Tschudin wrote:
> >>> There are error-prone memcpy() that can be replaced by struct
> >>> assignment that are type-safe and much easier to read. This semantic
> >>> patch looks for memcpy() that can be replaced by struct assignment.
> >> thanks for the script by Peter this script as it proved useful for Wine
> >> too. Though in one case it generated the wrong patch.
> >>
> >> @@
> >> struct struct_name to;
> >> struct struct_name from;
> >> @@
> >>
> >> 'to' and 'from' above are expressions and not identifiers; that's a
> >> feature. The bug happened in the replacement
> >> - memcpy(foos + count, &foo, sizeof(struct foo_t));
> >> + *foos + count = foo;
> >>
> >> Shouldn't cocinelle automatically add the parenthesis when prepending a
> >> '*' or '&' to an expression which isn't an identifier?
> >>
> >>
> >> The script itself is "safe" as the compiler will error out on that
> >> patch. And the people that just take generated patches and submit them
> >> without even compiling them deserve the public tar and feathering ;)
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
