From: neleai@seznam.cz (=?utf-8?B?T25kxZllaiBCw61sa2E=?=)
Date: Mon, 29 Jul 2013 17:59:20 +0200
Subject: [Cocci] Formatting issues
In-Reply-To: <51F68352.1060107@monom.org>
References: <51E6B08E.9030600@monom.org>
 <alpine.DEB.2.02.1307171706400.2113@hadrien>
 <51E6B532.8010909@monom.org>
 <alpine.DEB.2.02.1307171728420.2113@hadrien>
 <20130717155132.GA20499@domone.kolej.mff.cuni.cz>
 <51F62B0C.2040906@monom.org>
 <alpine.DEB.2.02.1307291047250.2271@hadrien>
 <51F630D7.1070701@monom.org>
 <20130729092851.GA8704@domone.kolej.mff.cuni.cz>
 <51F68352.1060107@monom.org>
Message-ID: <20130729155920.GA10905@domone.kolej.mff.cuni.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, Jul 29, 2013 at 04:59:30PM +0200, Daniel Wagner wrote:
> On 07/29/2013 11:28 AM, Ond?ej B?lka wrote:
> >On Mon, Jul 29, 2013 at 11:07:35AM +0200, Daniel Wagner wrote:
> >>On 07/29/2013 10:49 AM, Julia Lawall wrote:
> >>>It's a simple rule in theory, but not so simple in practice.  Pretty
> >>>printing is a hard problem, because doing a good job requires knowing both
> >>>what you have seen before and what is coming up.  Also, when Coccinelle is
> >>>generating code, it doesn't see the AST any more, only tokens, so it has
> >>>limited information.
> >>
> >>I understand that in reality this is a hard problem. Something what
> >>I would helpful here would be a list of lines (emacs/vim parseable)
> >>where the the result line is too long, presumed that detecting of
> >>long lines is easy.
> >>
> >I already did it in stylepp. You need to install it
> 
> Thanks, I give it a try.
> 
I now also wrote a similar tool,

stylepp_restrict_formater

It reverts changes on lines that were not touched in last commit so you
could use following:

apply patch,
git commit
for I in `git diff --name-only HEAD^`; do
  run favourite formatter
done
stylepp_restrict_formatter

It does not handle formatters that split lines yet.
A source is at script/stylepp_restrict_formatter src/_restrict_formatter.c 
so you could try to add it.
