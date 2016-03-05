From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sat, 5 Mar 2016 13:26:13 -0800
Subject: [Cocci] [PATCH v4 0/8] fix debugfs file removal races
In-Reply-To: <8737sjo7qa.fsf@gmail.com>
References: <8737sjo7qa.fsf@gmail.com>
Message-ID: <20160305212613.GA29738@kroah.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Feb 23, 2016 at 02:51:25PM +0100, Nicolai Stange wrote:
> The changes from v3 to v4 are style changes regarding the Coccinelle
> part only -- it has been split off from former [3/7] into its own
> patch [4/8].
> 
> The big step has been from v2 to v3 and these changes haven't got any
> review yet.

Well, given that they look sane to me, I've applied them to my tree,
let's see what breaks in linux-next now :)

thanks,

greg k-h
