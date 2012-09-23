From: jesper.louis.andersen@gmail.com (Jesper Louis Andersen)
Date: Mon, 24 Sep 2012 00:09:11 +0200
Subject: [Cocci] Clarification of work flows with content management
	systems
In-Reply-To: <505F7752.6030402@users.sourceforge.net>
References: <1348302555.11590.8.camel@ice-age.regit.org>
 <alpine.DEB.2.02.1209221907450.1899@localhost6.localdomain6>
 <1348352839.1867.8.camel@ice-age.regit.org>
 <alpine.DEB.2.02.1209231124210.1911@localhost6.localdomain6>
 <1348412844.1867.15.camel@ice-age.regit.org>
 <alpine.DEB.2.02.1209231713310.1952@localhost6.localdomain6>
 <505F7752.6030402@users.sourceforge.net>
Message-ID: <CAGrdgiUww7DKVCmU5FHQoL+jzPX9QjF4kQLATYbfaJf+SgPZpA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, Sep 23, 2012 at 10:55 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:

> I am curious to know a bit more about related issues. Can any versioning
> steps be improved here?

No.

Let me explain why I think no:

I know scores of competent programmers. The basic rule is that all of
those competent people work in different ways. They use different
editors, often with different tab-settings. They write their code in
different indentation styles. Some are vi users, some use emacs and
some took upon the newest kids on the block: Sublime Text, TextMate,
Eclipse. And some use old archaic editors like sam(1) still. Their
workflow differ: some write code in the morning, where I am normally
happily in bed sleeping. Some write code late in the night. Some will
appear offline for weeks on end and then suddenly have a brilliant
patch for a part of the code you are working on. Others meticulously
track their record in many small patches. They work in different
revision control systems. Some like tea while others like coffee. And
so on.

You can't enforce people to work in a specific way. And you shouldn't
- it would be outright rude to tell people that their way of working
is less efficient than some other way of working. Furthermore, you
can't in general change the way a project is maintained and steered,
unless it is your own. The power of Open Source is that you are free
to fork the project, or to maintain a branch next to it with smaller
changes. Git even makes it so easy it is ridiculous.

But I have a strong opinion that the creator and maintainer of the
project rules how contributions should happen and how the project
should be maintained. Of course, there is a responsibility to this -
if the project is poorly maintained it is harder to succeed. If the
project is too poorly maintained, it will either die or be forked,
whichever comes first. And I have a strong opinion that as long as you
follow the basic rules laid down by the maintainer, you are free to
operate as you see fit in that framing. Be it choice of editor,
workflow or espresso-addiction.

You may of course suggest, with a proper argument, why a certain way
of working in the workflow is sub-optimal. But the opinion of the
benevolent dictator is always right. Or you have not read enough
Machiavelli :)


-- 
J.
