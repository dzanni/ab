<?php
class dbl_sellers extends db_lib{
    const TABLE_NAME = "sellers";

    static function getXmlCode($code, $sellers, $OEM){
        if ($sellers == 2){ //Эксклюзив

            return "<a class='link' target='_blank' href='https://b2b.tyres.spb.ru/catalog/list?alias=tyre&TyreSearch%5B1c_txt%5D=".$OEM."&TyreSearch%5Bid_store%5D=&TyreSearch%5Bid_brand%5D=&TyreSearch%5Bw%5D=&TyreSearch%5Bh%5D=&TyreSearch%5Bd%5D=&TyreSearch%5Bseason%5D=&TyreSearch%5Bspike%5D=&TyreSearch%5BrunFlat%5D=&TyreSearch%5Bc%5D=&TyreSearch%5Bqnt%5D=&action=submit'>".$code."</a>";
        }elseif ($sellers == 3){ //4 tochki
            return "<a class='link' target='_blank' href='https://b2b.4tochki.ru/Product/Tire?kpt=1&fc_pst=1&cmpx=0&ft_do=&ft_w=&ft_h=&ft_d=&ft_s=&fc_b=&fc_c=".$code."&fc_vc=&ft_p=0&fc_mq=&fc_wh=1&fc_wh=232&fc_wh=9&fc_wh=3&fc_wh=18&fc_wh=825&fc_wh=4&ft_fs='>".$code."</a>";
        }elseif ($sellers == 4){ //shinservice
            return "<a class='link' target='_blank' href='https://duplo.shinservice.ru/tyre/search?q=".$code."'>".$code."</a>";
        }elseif ($sellers == 5){ // YST
            return "<a class='link' target='_blank' href='https://terminal.yst.ru/app/#/tyres/?filters=%7B%22range%22%3A%5B%22%22%5D,%22price%22%3A%5B1000,500000%5D,%22search%22%3A%22".$code."%22,%22onWarehouse%22%3Atrue%7D'>".$code."</a>";
        }elseif ($sellers == 6){ // GREEN TYRE
            return "<a class='link' target='_blank' href='https://greentyre.ru/b2b/products/?property_groupid=&property_132=&property_136=&property_131=&property_130=&property_134=&cae=".$code."&warehouse=&type=tyres&sort=name'>".$code."</a>";
            //
        }
    }
}