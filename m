From: joro@8bytes.org (=?iso-8859-1?Q?J=F6rg_R=F6del?=)
Date: Thu, 23 Oct 2014 14:51:54 +0200
Subject: [Cocci] [PATCH 1/1] IOMMU-MSM: Deletion of unnecessary checks
 before the function call "clk_disable"
In-Reply-To: <5447F0B1.9010707@users.sourceforge.net>
References: <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <5447F0B1.9010707@users.sourceforge.net>
Message-ID: <20141023125153.GC10053@8bytes.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Oct 22, 2014 at 08:00:17PM +0200, SF Markus Elfring wrote:
>  drivers/iommu/msm_iommu.c     | 3 +--
>  drivers/iommu/msm_iommu_dev.c | 6 ++----
>  2 files changed, 3 insertions(+), 6 deletions(-)

Applied to arm/msm, thanks.
