From: joe@perches.com (Joe Perches)
Date: Thu, 08 Sep 2016 19:56:25 -0700
Subject: [Cocci] [PATCH] da905x: Add const to da905x_regulator_info
	blocks
In-Reply-To: <bc2a69f70af39247994fd2b26e36d1b254576247.1473389324.git.joe@perches.com>
References: <bc2a69f70af39247994fd2b26e36d1b254576247.1473389324.git.joe@perches.com>
Message-ID: <1473389785.13672.25.camel@perches.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Julia.

Could coccinelle identify non-const arrays that are never modified
by anything and add const like this patch below by some mechanism?

---

On Thu, 2016-09-08 at 19:49 -0700, Joe Perches wrote:
> Moving data to text is a good thing.
> 
> 
> Mark the regulator_info structs as const and change the pointers to const.
> 
> 
> $ size drivers/regulator/*.o*
>    text	   data	    bss	    dec	    hex	filename
>    7455	    100	      0	   7555	   1d83	drivers/regulator/da9052-regulator.o.new
>    2111	   5392	      0	   7503	   1d4f	drivers/regulator/da9052-regulator.o.old
>    4321	    100	      0	   4421	   1145	drivers/regulator/da9055-regulator.o.new
>    2611	   1800	      0	   4411	   113b	drivers/regulator/da9055-regulator.o.old
> 
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/regulator/da9052-regulator.c | 37 ++++++++++++++++++------------------
>  drivers/regulator/da9055-regulator.c | 32 +++++++++++++++----------------
>  2 files changed, 34 insertions(+), 35 deletions(-)
> 
> 
> diff --git a/drivers/regulator/da9052-regulator.c b/drivers/regulator/da9052-regulator.c
> index 9ececfe..184ff1d 100644
> --- a/drivers/regulator/da9052-regulator.c
> +++ b/drivers/regulator/da9052-regulator.c
> @@ -75,11 +75,11 @@ struct da9052_regulator_info {
>  
>  struct da9052_regulator {
>  	struct da9052 *da9052;
> -	struct da9052_regulator_info *info;
> +	const struct da9052_regulator_info *info;
>  	struct regulator_dev *rdev;
>  };
>  
> -static int verify_range(struct da9052_regulator_info *info,
> +static int verify_range(const struct da9052_regulator_info *info,
>  			 int min_uV, int max_uV)
>  {
>  	if (min_uV > info->max_uV || max_uV < info->min_uV)
> @@ -159,7 +159,7 @@ static int da9052_list_voltage(struct regulator_dev *rdev,
>  				unsigned int selector)
>  {
>  	struct da9052_regulator *regulator = rdev_get_drvdata(rdev);
> -	struct da9052_regulator_info *info = regulator->info;
> +	const struct da9052_regulator_info *info = regulator->info;
>  	int id = rdev_get_id(rdev);
>  	int volt_uV;
>  
> @@ -183,7 +183,7 @@ static int da9052_map_voltage(struct regulator_dev *rdev,
>  			      int min_uV, int max_uV)
>  {
>  	struct da9052_regulator *regulator = rdev_get_drvdata(rdev);
> -	struct da9052_regulator_info *info = regulator->info;
> +	const struct da9052_regulator_info *info = regulator->info;
>  	int id = rdev_get_id(rdev);
>  	int ret, sel;
>  
> @@ -214,7 +214,7 @@ static int da9052_regulator_set_voltage_sel(struct regulator_dev *rdev,
>  					    unsigned int selector)
>  {
>  	struct da9052_regulator *regulator = rdev_get_drvdata(rdev);
> -	struct da9052_regulator_info *info = regulator->info;
> +	const struct da9052_regulator_info *info = regulator->info;
>  	int id = rdev_get_id(rdev);
>  	int ret;
>  
> @@ -245,7 +245,7 @@ static int da9052_regulator_set_voltage_time_sel(struct regulator_dev *rdev,
>  						 unsigned int new_sel)
>  {
>  	struct da9052_regulator *regulator = rdev_get_drvdata(rdev);
> -	struct da9052_regulator_info *info = regulator->info;
> +	const struct da9052_regulator_info *info = regulator->info;
>  	int id = rdev_get_id(rdev);
>  	int ret = 0;
>  
> @@ -330,7 +330,7 @@ static const struct regulator_ops da9052_ldo_ops = {
>  	.activate_bit = (abits),\
>  }
>  
> -static struct da9052_regulator_info da9052_regulator_info[] = {
> +static const struct da9052_regulator_info da9052_regulator_info[] = {
>  	DA9052_DCDC(BUCK1, 25, 500, 2075, 6, 6, DA9052_SUPPLY_VBCOREGO),
>  	DA9052_DCDC(BUCK2, 25, 500, 2075, 6, 6, DA9052_SUPPLY_VBPROGO),
>  	DA9052_DCDC(BUCK3, 25, 950, 2525, 6, 6, DA9052_SUPPLY_VBMEMGO),
> @@ -347,7 +347,7 @@ static struct da9052_regulator_info da9052_regulator_info[] = {
>  	DA9052_LDO(LDO10, 50, 1200, 3600, 6, 6, 0),
>  };
>  
> -static struct da9052_regulator_info da9053_regulator_info[] = {
> +static const struct da9052_regulator_info da9053_regulator_info[] = {
>  	DA9052_DCDC(BUCK1, 25, 500, 2075, 6, 6, DA9052_SUPPLY_VBCOREGO),
>  	DA9052_DCDC(BUCK2, 25, 500, 2075, 6, 6, DA9052_SUPPLY_VBPROGO),
>  	DA9052_DCDC(BUCK3, 25, 950, 2525, 6, 6, DA9052_SUPPLY_VBMEMGO),
> @@ -364,10 +364,10 @@ static struct da9052_regulator_info da9053_regulator_info[] = {
>  	DA9052_LDO(LDO10, 50, 1200, 3600, 6, 6, 0),
>  };
>  
> -static inline struct da9052_regulator_info *find_regulator_info(u8 chip_id,
> -								 int id)
> +static inline const struct da9052_regulator_info *
> +find_regulator_info(u8 chip_id, int id)
>  {
> -	struct da9052_regulator_info *info;
> +	const struct da9052_regulator_info *info;
>  	int i;
>  
>  	switch (chip_id) {
> @@ -435,14 +435,13 @@ static int da9052_regulator_probe(struct platform_device *pdev)
>  			return -ENODEV;
>  
>  		for_each_child_of_node(nproot, np) {
> -			if (!of_node_cmp(np->name,
> -					 regulator->info->reg_desc.name)) {
> -				config.init_data = of_get_regulator_init_data(
> -					&pdev->dev, np,
> -					&regulator->info->reg_desc);
> -				config.of_node = np;
> -				break;
> -			}
> +			if (of_node_cmp(np->name, regulator->info->reg_desc.name))
> +				continue;
> +			config.init_data =
> +				of_get_regulator_init_data(&pdev->dev, np,
> +							   &regulator->info->reg_desc);
> +			config.of_node = np;
> +			break;
>  		}
>  		of_node_put(nproot);
>  #endif
> diff --git a/drivers/regulator/da9055-regulator.c b/drivers/regulator/da9055-regulator.c
> index d029c94..019df70 100644
> --- a/drivers/regulator/da9055-regulator.c
> +++ b/drivers/regulator/da9055-regulator.c
> @@ -77,7 +77,7 @@ struct da9055_regulator_info {
>  
>  struct da9055_regulator {
>  	struct da9055 *da9055;
> -	struct da9055_regulator_info *info;
> +	const struct da9055_regulator_info *info;
>  	struct regulator_dev *rdev;
>  	enum gpio_select reg_rselect;
>  };
> @@ -85,7 +85,7 @@ struct da9055_regulator {
>  static unsigned int da9055_buck_get_mode(struct regulator_dev *rdev)
>  {
>  	struct da9055_regulator *regulator = rdev_get_drvdata(rdev);
> -	struct da9055_regulator_info *info = regulator->info;
> +	const struct da9055_regulator_info *info = regulator->info;
>  	int ret, mode = 0;
>  
>  	ret = da9055_reg_read(regulator->da9055, info->mode.reg);
> @@ -111,7 +111,7 @@ static int da9055_buck_set_mode(struct regulator_dev *rdev,
>  					unsigned int mode)
>  {
>  	struct da9055_regulator *regulator = rdev_get_drvdata(rdev);
> -	struct da9055_regulator_info *info = regulator->info;
> +	const struct da9055_regulator_info *info = regulator->info;
>  	int val = 0;
>  
>  	switch (mode) {
> @@ -133,7 +133,7 @@ static int da9055_buck_set_mode(struct regulator_dev *rdev,
>  static unsigned int da9055_ldo_get_mode(struct regulator_dev *rdev)
>  {
>  	struct da9055_regulator *regulator = rdev_get_drvdata(rdev);
> -	struct da9055_regulator_info *info = regulator->info;
> +	const struct da9055_regulator_info *info = regulator->info;
>  	int ret;
>  
>  	ret = da9055_reg_read(regulator->da9055, info->volt.reg_b);
> @@ -149,7 +149,7 @@ static unsigned int da9055_ldo_get_mode(struct regulator_dev *rdev)
>  static int da9055_ldo_set_mode(struct regulator_dev *rdev, unsigned int mode)
>  {
>  	struct da9055_regulator *regulator = rdev_get_drvdata(rdev);
> -	struct da9055_regulator_info *info = regulator->info;
> +	const struct da9055_regulator_info *info = regulator->info;
>  	struct da9055_volt_reg volt = info->volt;
>  	int val = 0;
>  
> @@ -171,7 +171,7 @@ static int da9055_ldo_set_mode(struct regulator_dev *rdev, unsigned int mode)
>  static int da9055_buck_get_current_limit(struct regulator_dev *rdev)
>  {
>  	struct da9055_regulator *regulator = rdev_get_drvdata(rdev);
> -	struct da9055_regulator_info *info = regulator->info;
> +	const struct da9055_regulator_info *info = regulator->info;
>  	int ret;
>  
>  	ret = da9055_reg_read(regulator->da9055, DA9055_REG_BUCK_LIM);
> @@ -186,7 +186,7 @@ static int da9055_buck_set_current_limit(struct regulator_dev *rdev, int min_uA,
>  					 int max_uA)
>  {
>  	struct da9055_regulator *regulator = rdev_get_drvdata(rdev);
> -	struct da9055_regulator_info *info = regulator->info;
> +	const struct da9055_regulator_info *info = regulator->info;
>  	int i;
>  
>  	for (i = ARRAY_SIZE(da9055_current_limits) - 1; i >= 0; i--) {
> @@ -204,7 +204,7 @@ static int da9055_buck_set_current_limit(struct regulator_dev *rdev, int min_uA,
>  static int da9055_regulator_get_voltage_sel(struct regulator_dev *rdev)
>  {
>  	struct da9055_regulator *regulator = rdev_get_drvdata(rdev);
> -	struct da9055_regulator_info *info = regulator->info;
> +	const struct da9055_regulator_info *info = regulator->info;
>  	struct da9055_volt_reg volt = info->volt;
>  	int ret, sel;
>  
> @@ -236,7 +236,7 @@ static int da9055_regulator_set_voltage_sel(struct regulator_dev *rdev,
>  					    unsigned int selector)
>  {
>  	struct da9055_regulator *regulator = rdev_get_drvdata(rdev);
> -	struct da9055_regulator_info *info = regulator->info;
> +	const struct da9055_regulator_info *info = regulator->info;
>  	int ret;
>  
>  	/*
> @@ -279,7 +279,7 @@ static int da9055_regulator_set_suspend_voltage(struct regulator_dev *rdev,
>  						int uV)
>  {
>  	struct da9055_regulator *regulator = rdev_get_drvdata(rdev);
> -	struct da9055_regulator_info *info = regulator->info;
> +	const struct da9055_regulator_info *info = regulator->info;
>  	int ret;
>  
>  	/* Select register set B for suspend voltage ramping. */
> @@ -301,7 +301,7 @@ static int da9055_regulator_set_suspend_voltage(struct regulator_dev *rdev,
>  static int da9055_suspend_enable(struct regulator_dev *rdev)
>  {
>  	struct da9055_regulator *regulator = rdev_get_drvdata(rdev);
> -	struct da9055_regulator_info *info = regulator->info;
> +	const struct da9055_regulator_info *info = regulator->info;
>  
>  	/* Select register set B for voltage ramping. */
>  	if (regulator->reg_rselect == NO_GPIO)
> @@ -314,7 +314,7 @@ static int da9055_suspend_enable(struct regulator_dev *rdev)
>  static int da9055_suspend_disable(struct regulator_dev *rdev)
>  {
>  	struct da9055_regulator *regulator = rdev_get_drvdata(rdev);
> -	struct da9055_regulator_info *info = regulator->info;
> +	const struct da9055_regulator_info *info = regulator->info;
>  
>  	/* Diselect register set B. */
>  	if (regulator->reg_rselect == NO_GPIO)
> @@ -425,7 +425,7 @@ static const struct regulator_ops da9055_ldo_ops = {
>  	},
>  }
>  
> -static struct da9055_regulator_info da9055_regulator_info[] = {
> +static const struct da9055_regulator_info da9055_regulator_info[] = {
>  	DA9055_BUCK(BUCK1, 25, 725, 2075, 6, 9, 0xc, 2),
>  	DA9055_BUCK(BUCK2, 25, 925, 2500, 6, 0, 3, 0),
>  	DA9055_LDO(LDO1, 50, 900, 3300, 6, 2),
> @@ -445,7 +445,7 @@ static int da9055_gpio_init(struct da9055_regulator *regulator,
>  			    struct regulator_config *config,
>  			    struct da9055_pdata *pdata, int id)
>  {
> -	struct da9055_regulator_info *info = regulator->info;
> +	const struct da9055_regulator_info *info = regulator->info;
>  	int ret = 0;
>  
>  	if (!pdata)
> @@ -521,9 +521,9 @@ static irqreturn_t da9055_ldo5_6_oc_irq(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> -static inline struct da9055_regulator_info *find_regulator_info(int id)
> +static inline const struct da9055_regulator_info *find_regulator_info(int id)
>  {
> -	struct da9055_regulator_info *info;
> +	const struct da9055_regulator_info *info;
>  	int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(da9055_regulator_info); i++) {
> 
> 
