From: hlovdal@gmail.com (=?UTF-8?B?SMOla29uIEzDuHZkYWw=?=)
Date: Sat, 17 Nov 2012 23:44:53 +0100
Subject: [Cocci] About conditional compilation
In-Reply-To: <SNT128-DS99EFC247F02BA51F061C09CFE0@phx.gbl>
References: <SNT128-DS99EFC247F02BA51F061C09CFE0@phx.gbl>
Message-ID: <CAACXqO_eBrXsRXpvSPXBsGttRsh+Y5-OAZSoK2HMHGv0ADjREQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 20 June 2012 08:10, yafo lee <yafo.lee@live.cn> wrote:
> Hi guys, I wanna delete conditional compilation code such as #ifdef, can
> Coccinelle do that?

The unifdef program, http://dotat.at/prog/unifdef/,  is created
specifically for such tasks:


(hlovdal) localhost:/tmp/test>cat test.c
#ifdef CONFIG_PM_SLEEP
static int alx_suspend(struct device *dev)
{
        struct pci_dev *pdev = to_pci_dev(dev);
        int retval;
        bool wakeup;

        retval = alx_shutdown_internal(pdev, &wakeup);
        if (retval)
                return retval;

        if (wakeup) {
                pci_prepare_to_sleep(pdev);
        } else {
                pci_wake_from_d3(pdev, false);
                pci_set_power_state(pdev, PCI_D3hot);
        }

        return 0;
}
#endif
(hlovdal) localhost:/tmp/test>unifdef -DCONFIG_PM_SLEEP test.c
static int alx_suspend(struct device *dev)
{
        struct pci_dev *pdev = to_pci_dev(dev);
        int retval;
        bool wakeup;

        retval = alx_shutdown_internal(pdev, &wakeup);
        if (retval)
                return retval;

        if (wakeup) {
                pci_prepare_to_sleep(pdev);
        } else {
                pci_wake_from_d3(pdev, false);
                pci_set_power_state(pdev, PCI_D3hot);
        }

        return 0;
}
(hlovdal) localhost:/tmp/test>

BR H?kon L?vdal
_______________________________________________
Cocci mailing list
Cocci at diku.dk
http://lists.diku.dk/mailman/listinfo/cocci
(Web access from inside DIKUs LAN only)
