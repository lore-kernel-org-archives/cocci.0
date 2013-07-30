From: wagi@monom.org (Daniel Wagner)
Date: Tue, 30 Jul 2013 23:06:08 +0200
Subject: [Cocci] Formatting issues
In-Reply-To: <20130729155920.GA10905@domone.kolej.mff.cuni.cz>
References: <51E6B08E.9030600@monom.org>
 <alpine.DEB.2.02.1307171706400.2113@hadrien> <51E6B532.8010909@monom.org>
 <alpine.DEB.2.02.1307171728420.2113@hadrien>
 <20130717155132.GA20499@domone.kolej.mff.cuni.cz>
 <51F62B0C.2040906@monom.org> <alpine.DEB.2.02.1307291047250.2271@hadrien>
 <51F630D7.1070701@monom.org> <20130729092851.GA8704@domone.kolej.mff.cuni.cz>
 <51F68352.1060107@monom.org>
 <20130729155920.GA10905@domone.kolej.mff.cuni.cz>
Message-ID: <51F82AC0.1010508@monom.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 07/29/2013 05:59 PM, Ond?ej B?lka wrote:
> On Mon, Jul 29, 2013 at 04:59:30PM +0200, Daniel Wagner wrote:
>> On 07/29/2013 11:28 AM, Ond?ej B?lka wrote:
>>> On Mon, Jul 29, 2013 at 11:07:35AM +0200, Daniel Wagner wrote:
>>>> On 07/29/2013 10:49 AM, Julia Lawall wrote:
>>>>> It's a simple rule in theory, but not so simple in practice.  Pretty
>>>>> printing is a hard problem, because doing a good job requires knowing both
>>>>> what you have seen before and what is coming up.  Also, when Coccinelle is
>>>>> generating code, it doesn't see the AST any more, only tokens, so it has
>>>>> limited information.
>>>>
>>>> I understand that in reality this is a hard problem. Something what
>>>> I would helpful here would be a list of lines (emacs/vim parseable)
>>>> where the the result line is too long, presumed that detecting of
>>>> long lines is easy.
>>>>
>>> I already did it in stylepp. You need to install it
>>
>> Thanks, I give it a try.
>>
> I now also wrote a similar tool,
>
> stylepp_restrict_formater
>
> It reverts changes on lines that were not touched in last commit so you
> could use following:
>
> apply patch,
> git commit
> for I in `git diff --name-only HEAD^`; do
>    run favourite formatter
> done
> stylepp_restrict_formatter

Thanks for the tipp. Since we are using pretty much the kernel codying 
style I just used checkpath.pl, that is

git diff | checkpatch.pl -

as compile command in emacs. Since emacs does not understand the 
error/warnings from checkpatch.pl (--emacs doesn't help because
the input file name is missing), I added a new compilation error regex 
rule to emacs. With that I can easly jump to the offendling lines and 
edit directly from emacs.

cheers,
daniel
