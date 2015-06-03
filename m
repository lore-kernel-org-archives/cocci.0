From: mmarek@suse.cz (Michal Marek)
Date: Wed, 3 Jun 2015 10:24:45 +0200
Subject: [Cocci] [PATCH] coccinelle: simple_return: Add a blank line
In-Reply-To: <alpine.DEB.2.02.1506020717430.2082@localhost6.localdomain6>
References: <1433209940-19303-1-git-send-email-festevam@gmail.com>
 <alpine.DEB.2.02.1506020717430.2082@localhost6.localdomain6>
Message-ID: <20150603082445.GA15819@sepie.suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Jun 02, 2015 at 07:18:07AM +0200, Julia Lawall wrote:
> On Mon, 1 Jun 2015, Fabio Estevam wrote:
> 
> > From: Fabio Estevam <fabio.estevam@freescale.com>
> > 
> > Insert a blank line in order to improve the readability of the
> > generated patch and also make it consistent with the other
> > .cocci files.
> 
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>

Applied to kbuild.git#misc.

Michal
