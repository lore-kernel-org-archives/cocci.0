From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 27 Aug 2014 09:00:41 +0200 (CEST)
Subject: [Cocci] pop up help info when execute "make coccicheck
 MODE=report "
In-Reply-To: <ffba896cad15400da11aee66ffcc30ed@BL2PR03MB404.namprd03.prod.outlook.com>
References: <e3e17c5bc09444cb9c0e5c30c306c5a3@BL2PR03MB404.namprd03.prod.outlook.com>
 <alpine.DEB.2.10.1408270847320.2620@hadrien>
 <ffba896cad15400da11aee66ffcc30ed@BL2PR03MB404.namprd03.prod.outlook.com>
Message-ID: <alpine.DEB.2.10.1408270858300.2620@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 27 Aug 2014, Xing Lei wrote:

> Hello,
>
> b45279 at bjsimics-OptiPlex-790:~$ spatch --version
> spatch version 1.0.0-rc14 with Python support and with PCRE support
> b45279 at bjsimics-OptiPlex-790:~$

OK, could you update and try again?  You can get version rc21 from github:

https://github.com/coccinelle/coccinelle.git

If you are using Ubuntu, you can also get the precompiled version here:

https://launchpad.net/~npalix/+archive/ubuntu/coccinelle

julia


>
> B.R.
> Xing
>
> -----Original Message-----
> From: Julia Lawall [mailto:julia.lawall at lip6.fr]
> Sent: Wednesday, August 27, 2014 2:49 PM
> To: Lei Xing-B45279
> Cc: cocci at systeme.lip6.fr; ldup-devel at gforge.freescale.net
> Subject: Re: [Cocci] pop up help info when execute "make coccicheck MODE=report "
>
> On Tue, 26 Aug 2014, Xing Lei wrote:
>
> >
> > Hi All,
> >
> > I met a issue about coccinelle, some help info pop out when I use
> > coccinelle analysis a folder as below.
>
> What version of Coccinelle do you have?
>
> julia
>
> >
> > What?s the reason for it? If anything is wrong with some files in folder?
> >
> > ?
> >
> > ?
> >
> > make coccicheck MODE=report M=drivers/net/ethernet/freescale
> >
> > ?
> >
> > Please check for false positives in the output before submitting a patch.
> >
> > When using "patch" mode, carefully review the patch before submitting it.
> >
> > ?
> >
> > drivers/net/ethernet/freescale/fman/Peripherals/FM/Pcd/fm_pcd.c:279:2-7:
> > WARNING: NULL check before freeing functions like kfree,
> > debugfs_remove, debugfs_remove_recursive or usb_free_urb is not
> > needed. Maybe consider reorganizing relevant code to avoid passing NULL values.
> >
> > drivers/net/ethernet/freescale/fman/Peripherals/FM/Port/fm_port.c:1899:2-7:
> > WARNING: NULL check before freeing functions like kfree,
> > debugfs_remove, debugfs_remove_recursive or usb_free_urb is not
> > needed. Maybe consider reorganizing relevant code to avoid passing NULL values.
> >
> > drivers/net/ethernet/freescale/fman/Peripherals/FM/Port/fm_port.c:536:2-7:
> > WARNING: NULL check before freeing functions like kfree,
> > debugfs_remove, debugfs_remove_recursive or usb_free_urb is not
> > needed. Maybe consider reorganizing relevant code to avoid passing NULL values.
> >
> > drivers/net/ethernet/freescale/fman/Peripherals/FM/fm.c:2208:2-7: WARNING:
> > NULL check before freeing functions like kfree, debugfs_remove,
> > debugfs_remove_recursive or usb_free_urb is not needed. Maybe consider
> > reorganizing relevant code to avoid passing NULL values.
> >
> > Usage: spatch --sp-file <SP> <infile> [-o <outfile>] [--iso-file
> > <iso>] [options]
> >
> > Options are:
> >
> > ? --sp-file??????????????????? <file> the semantic patch file
> >
> > ? -o?????????????????????????? <file> the output file
> >
> > ? --in-place?????????????????? do the modification on the file
> > directly
> >
> > ? --backup-suffix????????????? suffix to use when making a backup for
> > inplace
> >
> > ? --out-place????????????????? store modifications in a .cocci_res
> > file
> >
> > ? --reverse??????????????????? invert the semantic patch before
> > applying it
> >
> > ? -U?????????????????????????? set number of diff context lines
> >
> > ? --partial-match????????????? report partial matches of the SP on the
> > C file
> >
> > ? --iso-file?????????????????? <file>
> > (default=/usr/share/coccinelle/standard.iso)
> >
> > ? --macro-file???????????????? <file>
> >
> > ? --macro-file-builtins??????? <file>
> > (default=/usr/share/coccinelle/standard.h)
> >
> > ? --recursive-includes???????? causes all available include files,
> > both those included in the C file(s) and those included in header
> > files, to be used
> >
> > ? --all-includes?????????????? causes all available include files
> > included in the C file(s) to be used
> >
> > ? --no-includes??????????????? causes not even local include files to
> > be used
> >
> > ? --local-includes???????????? causes local include files to be used
> >
> > ? --ignore-unknown-options???? For integration in a toolchain (must be
> > set before the first unknown option)
> >
> > ? --include-headers??????????? process header files independently
> >
> > ? -I?????????????????????????? <dir> containing the header files
> > (optional)
> >
> > ? --preprocess???????????????? run the C preprocessor before applying
> > the semantic match
> >
> > ? -c?????????????????????????? gcc/cpp compatibility mode
> >
> > ? --dir??????????????????????? <dir> process all files in directory
> > recursively
> >
> > ? --use-glimpse??????????????? works with -dir, use info generated by
> > glimpseindex
> >
> > ? --use-google???????????????? find relevant files using google code
> > search
> >
> > ? --use-idutils??????????????? find relevant files using id-utils
> >
> > ? --patch????????????????????? <dir> path name with respect to which a
> > patch should be created
> >
> > ? ??"" for a file in the current directory
> >
> > ? --kbuild-info??????????????? <file> improve -dir by grouping related
> > c files
> >
> > ? --pyoutput?????????????????? Sets output routine: Standard values:
> > <coccilib.output.Gtk|coccilib.output.Console>
> >
> > ? --version????????? ??????????guess what
> >
> > ? --date?????????????????????? guess what
> >
> > ? --shorthelp????????????????? see short list of options
> >
> > ? --longhelp?????????????????? see all the available options in
> > different categories
> >
> > ? -help
> >
> > ??--help
> >
> > ?
> >
> > ?
> >
> > ?
> >
> > Best Regards
> >
> > Xing
> >
> > ?
> >
> >
> >
>
