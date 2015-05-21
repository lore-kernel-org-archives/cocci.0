From: mmarek@suse.cz (Michal Marek)
Date: Thu, 21 May 2015 14:28:10 +0800
Subject: [Cocci] [PATCHv2] coccinelle: api: add vma_pages.cocci
In-Reply-To: <alpine.DEB.2.02.1505172225270.2077@localhost6.localdomain6>
References: <alpine.DEB.2.02.1505171526430.2077@localhost6.localdomain6>
 <1431879810-20920-1-git-send-email-dmitry.kalinkin@gmail.com>
 <alpine.DEB.2.02.1505172225270.2077@localhost6.localdomain6>
Message-ID: <555D7AFA.9070102@suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Dne 18.5.2015 v 04:25 Julia Lawall napsal(a):
> On Sun, 17 May 2015, Dmitry Kalinkin wrote:
>> This semantic patch replaces explicit computations of vma page count
>> with explicit function call.
>>
>> Signed-off-by: Dmitry Kalinkin <dmitry.kalinkin@gmail.com>
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>

Thanks, applied to kbuild.git#misc.

Michal
