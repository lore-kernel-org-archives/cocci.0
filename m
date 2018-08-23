From: joe@perches.com (Joe Perches)
Date: Thu, 23 Aug 2018 15:21:40 -0700
Subject: [Cocci] [Fwd: Re: [PATCH] rtc: sun6i: Use struct_size() in
	kzalloc()]
In-Reply-To: <alpine.DEB.2.21.1808231811110.2376@hadrien>
References: <CAGXu5jKPOVRk5DbFMKu0BV_K-ES+j+6_aApjyo0X8zXBfTYDnw@mail.gmail.com>
 <700bfdf296aa112799b6a6f091162cc34f6fef10.camel@perches.com>
 <CAGXu5jL3C78vkVL968HtBdLZgRYYQp4_pTKMT=BTJnk5z6CH3w@mail.gmail.com>
 <alpine.DEB.2.21.1808231759050.2376@hadrien>
 <CAGXu5jLjOtG0jTt2ZVyZe7ivBfZhRTyOKai0fHMzPFxUCr3LRg@mail.gmail.com>
 <alpine.DEB.2.21.1808231811110.2376@hadrien>
Message-ID: <4a992fbb6ae172baf3c76ed979bf6804914b089e.camel@perches.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 2018-08-23 at 18:13 -0400, Julia Lawall wrote:
> 
> On Thu, 23 Aug 2018, Kees Cook wrote:
> 
> > On Thu, Aug 23, 2018 at 3:00 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> > > 
> > > 
> > > On Thu, 23 Aug 2018, Kees Cook wrote:
> > > 
> > > > On Thu, Aug 23, 2018 at 2:48 PM, Joe Perches <joe@perches.com> wrote:
> > > > > Forwarding a question about coccinelle and isomorphisms from Kees Cook
> > > > > 
> > > > > ---------- Forwarded message ----------
> > > > > From: Kees Cook <keescook@chromium.org>
> > > > > To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
> > > > > Cc: Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, linux-rtc at vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>
> > > > > Bcc:
> > > > > Date: Thu, 23 Aug 2018 13:56:35 -0700
> > > > > Subject: Re: [PATCH] rtc: sun6i: Use struct_size() in kzalloc()
> > > > > On Thu, Aug 23, 2018 at 11:51 AM, Gustavo A. R. Silva
> > > > > <gustavo@embeddedor.com> wrote:
> > > > > > One of the more common cases of allocation size calculations is finding
> > > > > > the size of a structure that has a zero-sized array at the end, along
> > > > > > with memory for some number of elements for that array. For example:
> > > > > > 
> > > > > > struct foo {
> > > > > >         int stuff;
> > > > > >         void *entry[];
> > > > > > };
> > > > > > 
> > > > > > instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
> > > > > > 
> > > > > > Instead of leaving these open-coded and prone to type mistakes, we can
> > > > > > now use the new struct_size() helper:
> > > > > > 
> > > > > > instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
> > > > > > 
> > > > > > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > > > > > ---
> > > > > >  drivers/rtc/rtc-sun6i.c | 3 +--
> > > > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
> > > > > > index 2cd5a7b..fe07310 100644
> > > > > > --- a/drivers/rtc/rtc-sun6i.c
> > > > > > +++ b/drivers/rtc/rtc-sun6i.c
> > > > > > @@ -199,8 +199,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
> > > > > >         if (!rtc)
> > > > > >                 return;
> > > > > > 
> > > > > > -       clk_data = kzalloc(sizeof(*clk_data) + (sizeof(*clk_data->hws) * 2),
> > > > > > -                          GFP_KERNEL);
> > > > > > +       clk_data = kzalloc(struct_size(clk_data, hws, 2), GFP_KERNEL);
> > > > > >         if (!clk_data) {
> > > > > >                 kfree(rtc);
> > > > > >                 return;
> > > > > 
> > > > > This looks like entirely correct to me, but I'm surprised the
> > > > > Coccinelle script didn't discover this. I guess the isomorphisms don't
> > > > > cover the parenthesis?
> > > > 
> > > > I had this:
> > > > 
> > > > @@
> > > > identifier alloc =~
> > > > "kmalloc|kzalloc|kmalloc_node|kzalloc_node|vmalloc|vzalloc|kvmalloc|kvzalloc";
> > > > identifier VAR, ELEMENT;
> > > > expression COUNT;
> > > > @@
> > > > 
> > > > - alloc(sizeof(*VAR) + COUNT * sizeof(*VAR->ELEMENT)
> > > > + alloc(struct_size(VAR, ELEMENT, COUNT)
> > > >   , ...)
> > > > 
> > > > But I needed to explicitly change the rule to:
> > > > 
> > > > (
> > > > - alloc(sizeof(*VAR) + COUNT * sizeof(*VAR->ELEMENT)
> > > > + alloc(struct_size(VAR, ELEMENT, COUNT)
> > > >   , ...)
> > > > > 
> > > > 
> > > > - alloc(sizeof(*VAR) + (COUNT * sizeof(*VAR->ELEMENT))
> > > > + alloc(struct_size(VAR, ELEMENT, COUNT)
> > > >   , ...)
> > > > )
> > > > 
> > > > to add the ()s. I would expect arithmetic commutative expressions to
> > > > match? But I had to add parens?
> > > 
> > > Isomorphisms don't add parens.  They only remove them.  If they added
> > > them, you would end up with the possibility of having them everywhere, in
> > > all permutations, which would be slow and useless.
> > 
> > Would a rule for:
> > 
> > a + (b * c)
> > 
> > match:
> > 
> > a + b * c
> 
> I would say yes.  Basically it removes the parentheses but doesn't reparse
> the code, so it doesn't redo the associativity.  Since * has higher
> precedence than +, then both will be matched.  On the other hand, if you
> put:
> 
> (a + b) * c
> 
> It will consider a pattern with the parentheses removed, but that pattern
> won't match anything, because real trees that consist of a + b * c are
> parsed in a different way.

spatch 1.0.4 doesn't seem to:

$ spatch --version
spatch version 1.0.4 with Python support and with PCRE support
$ cat match_mul.cocci 
@@
expression a, b, c;
int d;
@@

*	d = a * b + c;
$ cat test_mul.c 
int a, b, c, d;

void foo(void)
{
	d = (a * b) + c;
	d = a * b + c;
}
$ spatch -sp-file match_mul.cocci test_mul.c
init_defs_builtins: /usr/lib/coccinelle/standard.h
HANDLING: test_mul.c
diff = 
--- test_mul.c
+++ /tmp/cocci-output-22607-ba6f76-test_mul.c
@@ -3,5 +3,4 @@ int a, b, c, d;
 void foo(void)
 {
 	d = (a * b) + c;
-	d = a * b + c;
 }
