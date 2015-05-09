From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Sat, 9 May 2015 18:49:47 +0200
Subject: [Cocci] Question about the use of "...when !=" in SmPL
In-Reply-To: <20150509140941.GA13643@opentech.at>
References: <BAY181-W739E92CD2131317A21ED42B8DF0@phx.gbl>
 <20150509140941.GA13643@opentech.at>
Message-ID: <20150509164947.GA12173@opentech.at>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 09 May 2015, Nicholas Mc Guire wrote:

> On Thu, 07 May 2015, ZhouYuan wrote:
> 
> your second question regardin if/else was not yet addressed - so here are
> some notes on trying to solve this - again this might not be the right 
> approach - only got it to work by removing the if structure isomorphisms !
> 
> <snip>
> > 
> >    Also, another example can be witnessed here. I wrote another patch to
> >    check whether there is an "else" after  "if" statement:
> > 
> >      @rule534@
> >      function F;
> >      position p;
> >      statement S1, S2;
> >      @@
> >      F at p (...){
> >      if (...) S1
> >      ...when != else S2
> >      }
> > 
> >    But i also got the same "minus: parse error" at the line of when.
> >    I would be so appreciated if someone could give me some suggestions about
> >    what is wrong in my Patch and how to use when correctly.
> >    Thank you so much!
>
forget my first attempt - obviously confused my self sufficiently to find
a very complicated solution to a simple problem - no need to change the
iso file either....

<snip>
virtual report                                                                  
virtual org

@ifonly@
function f;
statement S1;
position p;
@@
f (...){
<...
*if@p (...) S1
...>
}

@script: python depends on ifonly@
p<<ifonly.p;
@@
print "%s %s if without else" % (p[0].file, p[0].line)
<snip>

note that if one really would need to disable some specific isomorphism
then one can do that with "disable" e.g. from the "if structure isomorphisms"
section in standard.iso you could selectively disable neg_if and ne_if like
so:

@ifonly disable ne_if,neg_if@
(see http://www.emn.fr/z-info/coccinelle/docs/main_grammar002.html#disable-iso)

but for this case this is not needed anyway.

So the only problem with your soluion was that you were trying to explicitly
describe the absence while all you would need is to describe what you want
to see. 

Just ran this on the kernel and the first few pages of output looked like 
its working.

thx!
hofrat 
