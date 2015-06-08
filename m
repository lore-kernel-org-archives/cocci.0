From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Mon, 8 Jun 2015 12:31:01 -0700
Subject: [Cocci] [PATCH 3/4] gentree.py: add SmPL patch equivalence
	proof support
In-Reply-To: <1433592743.2467.7.camel@sipsolutions.net>
References: <1433549401-17006-1-git-send-email-mcgrof@do-not-panic.com>
 <1433549401-17006-4-git-send-email-mcgrof@do-not-panic.com>
 <1433592743.2467.7.camel@sipsolutions.net>
Message-ID: <CAB=NE6X6=uuof0BdhVctobb_Ypvj-Q03Akma_PWGe17PUn=7PA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, Jun 6, 2015 at 5:12 AM, Johannes Berg <johannes@sipsolutions.net> wrote:
> On Fri, 2015-06-05 at 17:10 -0700, Luis R. Rodriguez wrote:
>> If you have an SmPL patch that you think is ready to replace
>> a series of unified diff patches you can pass as an argument
>> to gentree.py '--prove-cocci' with the cocci file as the
>> an extra argument and gentree.py will try to prove equivalence
>> between the unified diff series and your Coccinelle SmPL patch.
>>
>> You can use this as a guide when trying to replace an existing
>> unified diff series carried within backports with a respective
>> Coccinelle SmPL patch. You can use this to get a warm fuzzy or
>> to provide backports maintainers with a warm fuzzy of comfort
>> that your SmPL patch is sufficient.
>
> I don't like this at all.
>
> gentree.py is supposed to be a tool to generate a new backport tree.
> You're (ab)using it for (s)patch development purposes that it was never
> intended for.

This is true, its in the like of how we wrote pycocci to provide us
with a multithreaded solution for spatch integration / development as
well and how pycocci now is upstream on Coccinelle. That will / can be
used until Coccinelle completes integration of wrapping up its
multithreaded solution in a slightly different way.

> It's already grown to be a spaghetti mess of different options, some of
> which cause partial tree creation (or no proper tree creation at all,
> iirc) and I think adding more to this will make it unmaintainable.

Yeah I can see that, it might already be pretty complex as-is.

> Additionally, there's no real reason why this needs to be part of
> gentree. In theory, you can just apply both patches to any kind of tree
> (doesn't have to be a backport) and see the difference.

Indeed, my original goal was to generalize this but I just never got
to it. I had a need for this again now, so I rebased it based on an
old patch.

> In practice, I understand that it might make sense to apply them to a
> backport tree because that's where the original patch (non-spatch) came
> from, since presumably you want to use it for development. However, I
> still think this is far enough from the original purpose just like
> test_cocci and profile_cocci that it shouldn't be there.

Sure, at least for this functionality the way it handles series is
specialized to backports, ie, series-name-foo.cocci and assuming
their's an equivalent unified patch equivalent series under
series-name-foo/, but this can be generalized as part of a tool as
well.

> I'd support changing gentree to support a "up to this patch" mode, in
> which it stops processing at a certain patch and other scripts can then
> do remaining work like cocci profiling (which IMHO really shouldn't be
> here at all) or this comparison testing.

OK sure, agreed.

> I can also see how adding more to this script is convenient, since it's
> just a few lines of code in the right place in the script, but this has
> already made it complicated to follow all the different code paths and
> change them appropriately for any changes.

Agreed.

> As a consequence, I cannot support this change and would much rather
> remove more of the cocci test options from here - really something like
> profiling and equivalence testing should be part of a script provided by
> upstream coccinelle anyway, instead of in the backports project.

--test-cocci provides the similar functionality as you describe above
to "stop after", in this case its just "apply only this series".
Perhaps --test-cocci should be replaced with --only-this-series or
something like that and/or --stop-on-series. Both would suffice for an
external tool to them go and do the tests we need.

In so far as where else to put this functionality into, since pycocci
is now part of Coccinelle, I could try to put that there.

I won't merge this then but I will note that I find this extremely
useful for spatch development, I am not sure when I'll get time to
integrate into pycocci which is why for convenience purpose did the
respin. Folks who want this will just have to take this patch on their
own and use it until we implement this into Coccinelle somehow
directly (pycocci or others).

 Luis
