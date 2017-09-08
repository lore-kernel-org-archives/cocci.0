From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 8 Sep 2017 08:58:14 +0200
Subject: [Cocci] Checking statement order for patch generation with SmPL
	support
In-Reply-To: <alpine.DEB.2.20.1709072323500.10609@hadrien>
References: <2a2b1ae2-ff84-2bda-3701-548dd9ee1edf@users.sourceforge.net>
 <alpine.DEB.2.20.1709071519240.3168@hadrien>
 <c803beac-9fbe-f52d-18b5-6ef3ca3cbcb3@users.sourceforge.net>
 <alpine.DEB.2.20.1709071619340.3168@hadrien>
 <a99dbaa2-8bfd-7ee1-0122-9b99d4d9fdda@users.sourceforge.net>
 <alpine.DEB.2.20.1709072323500.10609@hadrien>
Message-ID: <a83f4728-b720-99e3-ae61-f3ccb6b19e48@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> I wonder also about the information how an ordinary for loop could influence
>> the shown source code analysis result for the function ?snd_seq_queue_find_name?
>> when the questionable marked statements are contained in a single if branch.
>> http://elixir.free-electrons.com/linux/v4.13/source/sound/core/seq/seq_queue.c#L241
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/sound/core/seq/seq_queue.c?id=c6be5a0e3cebc145127d46a58350e05d2bcf6323#n252
> 
> I don't understand the question.

I hope that we can achieve a better common understanding also for the mentioned
test examples.


> I already explained the issue here.

You tried it.


> Execution can go from queuefree to the top of the loop, to the first if in
> the loop to the second if in the loop that has the dereference.  That is
> how loops work.

I can agree to this view.

But I find the existence of a loop not so relevant for the source code
search pattern which is discussed.


>> @@ -1199,14 +1199,11 @@ void dpcm_be_disconnect(struct snd_soc_p
>>  			stream ? "<-" : "->", dpcm->be->dai_link->name);
>>
>>  		/* BEs still alive need new FE */
>> -		dpcm_be_reparent(fe, dpcm->be, stream);
>>
>>  #ifdef CONFIG_DEBUG_FS
>> -		debugfs_remove(dpcm->debugfs_state);
>>  #endif
>>  		list_del(&dpcm->list_be);
>>  		list_del(&dpcm->list_fe);
>> -		kfree(dpcm);
>>  	}
>>  }
>>
>>
>> I find the shown matches also questionable for this test result.
>> Would you like to clarify such software situations a bit more
>> for the desired handling of statement sequences?
> 
> The list_for_each_entry_safe operator also makes a loop.

Yes. - But how could the Coccinelle software know more about this identifier
during execution of the small script ?show_use_after_free3.cocci? than
that it is a macro call in the implementation of the function ?dpcm_be_disconnect?
(when extra include parameters were not specified)?
http://elixir.free-electrons.com/linux/v4.13/source/include/linux/list.h#L542
http://elixir.free-electrons.com/linux/v4.13/source/sound/soc/soc-pcm.c#L1184

Do you find the minus characters appropriate at the beginning of these three lines?

Regards,
Markus
