From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 4 Jul 2017 15:32:25 +0200 (CEST)
Subject: [Cocci] Matching format strings
In-Reply-To: <20170704132241.nzin5ihmmhzk2puf@eos.mistotebe.net>
References: <20170629160437.nvpn32fsetlzvni7@eos.mistotebe.net>
 <alpine.DEB.2.20.1706291026390.2983@hadrien>
 <WM!fa141e32a0b1e5356bb136cefca80be54d02a269aa1d5e1c1d01b9dd1e9da14f2f9fffdc08676c298a48132a86f2037e!@mailstronghold-1.zmailcloud.com>
 <20170629175852.trzk7w6nwxswzi5x@eos.mistotebe.net>
 <alpine.DEB.2.20.1706291733320.2968@hadrien>
 <WM!a6114e049b67df39e40551cd95bf5d65e432ff2f8c0445b0273a6b12349ae6346924a09e4c027fdcc87febe26a5e6a4e!@mailstronghold-2.zmailcloud.com>
 <20170630135727.lyjp7ayalzxf73jf@eos.mistotebe.net>
 <20170704132241.nzin5ihmmhzk2puf@eos.mistotebe.net>
Message-ID: <alpine.DEB.2.20.1707041531280.3224@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> The main problem that is holding me up is that coccinelle fails with the
> following error when trying to use the patch against the code above:
> Fatal error: exception Common.Impossible(145)

You need

identifier b_process.merged;

instead of

expression b_process.merged;

When you do that, you will see that some more quotes are needed on the
string.

julia
