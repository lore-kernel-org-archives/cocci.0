From: mmarek@suse.cz (Michal Marek)
Date: Mon, 24 Nov 2014 22:03:52 +0100
Subject: [Cocci] bugon.cocci: fix Options at the macro
In-Reply-To: <20141121180747.GA3754@katana>
References: <20141028151824.4b41986f@recife.lan>
 <20141107175105.GC3656@katana> <20141121180747.GA3754@katana>
Message-ID: <54739D38.7070507@suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Dne 21.11.2014 v 19:07 Wolfram Sang napsal(a):
> On Fri, Nov 07, 2014 at 06:51:05PM +0100, Wolfram Sang wrote:
>> On Tue, Oct 28, 2014 at 03:18:24PM -0200, Mauro Carvalho Chehab wrote:
>>> The comma after --no-includes makes coccinelle to not run the script:
>>>
>>> /usr/bin/spatch -D report --very-quiet --no-show-diff --cocci-file ./scripts/coccinelle/misc/bugon.cocci --no-includes, --include-headers --patch . --dir drivers/media/platform/coda/ -I ./arch/x86/include -I arch/x86/include/generated -I include -I ./arch/x86/include/uapi -I arch/x86/include/generated/uapi -I ./include/uapi -I include/generated/uapi -I ./include/linux/kconfig.h
>>> Usage: spatch.opt --sp-file <SP> <infile> [-o <outfile>] [--iso-file <iso>] [options]
>>> Options are:
>>>   --sp-file                    <file> the semantic patch file
>>>   -o                           <file> the output file
>>>   --in-place                   do the modification on the file directly
>>>   --backup-suffix              suffix to use when making a backup for inplace
>>> ...
>>>
>>> At least with Fedora 20 coccinelle package:
>>> 	coccinelle-1.0.0-0.rc20.1.fc21.x86_64
>>>
>>> Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
>>
>> Yay, with this my patch handling scripts finally work again as they used
>> to! Please let it go into 3.18.
>>
>> Tested-by: Wolfram Sang <wsa@the-dreams.de>
> 
> Ping.

Sorry for the delay. Applied now to kbuild.git#misc.

Michal
