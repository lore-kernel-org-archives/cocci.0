From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed, 15 Jun 2016 22:00:49 +0200
Subject: [Cocci] [PATCH v3 4/6] coccicheck: add indexing enhancement
 options
In-Reply-To: <trinity-93871e91-5a63-4aac-9026-bb2f97d8f384-1465989619464@3capp-webde-bap45>
References: <20160614201923.GC11948@wotan.suse.de>
 <1465935820-14010-1-git-send-email-mcgrof@kernel.org>
 <1465935820-14010-5-git-send-email-mcgrof@kernel.org>
 <trinity-93871e91-5a63-4aac-9026-bb2f97d8f384-1465989619464@3capp-webde-bap45>
Message-ID: <20160615200049.GZ11948@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Jun 15, 2016 at 01:20:19PM +0200, SF Markus Elfring wrote:
> > +DIR=$(dirname $(readlink -f $0))
> > +DIR="${DIR}/../"
> 
> How do you think about to merge these variable assignments also into one?
> 
> +DIR="$(dirname $(readlink -f $0))/../"

Sure.

  Luis
