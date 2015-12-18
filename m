From: dganesan@fc-md.umd.edu (Dharmalingam Ganesan)
Date: Fri, 18 Dec 2015 12:53:28 -0500
Subject: [Cocci] Coccinelle for other programming languages
In-Reply-To: <alpine.DEB.2.10.1512181745050.2499@hadrien>
References: <B517F47C2F6D914AA8121201F9EBEE6701C7CF57C22C@Mail1.FCMD.local>
 <alpine.DEB.2.10.1512171825240.10291@hadrien>
 <20151217221143.GV20409@wotan.suse.de>
 <5673BF55.4010902@users.sourceforge.net>
 <B517F47C2F6D914AA8121201F9EBEE6701C7CF57C282@Mail1.FCMD.local>
 <alpine.DEB.2.10.1512181603050.2499@hadrien>
 <B517F47C2F6D914AA8121201F9EBEE6701C7CF57C291@Mail1.FCMD.local>
 <alpine.DEB.2.10.1512181745050.2499@hadrien>
Message-ID: <B517F47C2F6D914AA8121201F9EBEE6701C7CF57C29A@Mail1.FCMD.local>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

Thanks a  lot.

I tried to run the attached cocci script on the attached C file. We got an error.

Not sure whether the cocci files under the script directory are for the users to try or for other programs.

Any comments?
Dharma 

-----Original Message-----
From: Julia Lawall [mailto:julia.lawall at lip6.fr] 
Sent: Friday, December 18, 2015 11:46 AM
To: Dharmalingam Ganesan
Cc: SF Markus Elfring; Luis R. Rodriguez; cocci at systeme.lip6.fr
Subject: RE: [Cocci] Coccinelle for other programming languages



On Fri, 18 Dec 2015, Dharmalingam Ganesan wrote:

> Thanks for the quick response. I'm watching your youtube videos.
>
> I saw " She develops the tool Coccinelle and has over 1000 patches in the Linux kernel based on this work".
>
> Is it possible to get access to all your patches? I went over the Coccinelle web page gallery, but not sure it has 1000 patches.

http://cp.mcafee.com/d/5fHCNESyM_txYsyYUrKrjKYyYMM-yCrjKYyYMM-UOrjKYyYMM-yMrjKYCVtxdVcSwhS7QS0atInlgVJl3LgrdKSbGEsSGxTEdCQn7Cm1Pz_nV55Mse78ZuVtddNzAS3hOO-CqeumKzp55mWbDaxVZicHs3jq9J4TvC7Amm7HKfcCXCOsVHkiP2cFYl-cffU03w2jM-k6M_2LNxV-4pjO7xYYfB1IfbMYfDN6kYfGhMB90WfKQ7FyYZ8Q7FyYf3VBQXELEFELd2QPJrCjH5Eme2KCdffdybpYJU_j6DDwE-iPDeNdFTsodwIqid41Fr4GSJ8QKCy0iHqQEuuvVEwtH4QglCj-9Ewmzkz7llpg8Cy0_o4mZ8_gS-Mrk49dAp-C

julia
-------------- next part --------------
A non-text attachment was scrubbed...
Name: screenshot __spatch -cocci_file notand.cocci notand.c__.png
Type: image/png
Size: 112518 bytes
Desc: screenshot __spatch -cocci_file notand.cocci notand.c__.png
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20151218/b2a36fdb/attachment-0002.png>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: Screenshot __notand.c__.png
Type: image/png
Size: 69170 bytes
Desc: Screenshot __notand.c__.png
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20151218/b2a36fdb/attachment-0003.png>
