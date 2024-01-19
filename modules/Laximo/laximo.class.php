<?php  
	require_once('laximo/guayaquillib/data/requestOem.php');
	require_once('laximo/config.php');
	class laximo {
		static function getCatalogFirstLevel($filter){
			if ($filter == "all_brands"){
				$filter = "";
			}
			$request = new GuayaquilRequestOEM('', '', Config::$catalog_data);
			if (Config::$useLoginAuthorizationMethod) {
				$request->setUserAuthorizationMethod(Config::$userLogin, Config::$userKey);
			}
			
			// Append commands to request
			$request->appendListCatalogs();
			
			// Execute request
			$data = (array) $request->query();
			$data = $data[0]->row;
			$tmp = array();
			for($i=0;$i<count($data);$i++){
				$tmp[$i] = self::adapterFirstLevel($data[$i]);
			}
 
			return self::mkFilter($filter, $tmp);
		}
		static function mkFilter($filter, $data){
			if ($filter <> ""){
				$res = array();
				for($i=0;$i<count($data);$i++){ 
					if (substr_count(mb_strtolower($data[$i]['name'], 'UTF-8'), mb_strtolower($filter, 'UTF-8'))){
						$res[] = $data[$i];
					}
				}
			} 
			return $res;
		}
		static function adapterFirstLevel($data){ 
			$tmp = array(
					"code"  => (string) $data['code'],
					"brand" => (string) $data['brand'], 
					"name" => (string) $data['name']
				);
			$features = array();  
			foreach ($data->features->feature as $key => $value){
				$name = (string) $value['name'];
				$features[$name] = $value;
			} 
			$tmp['features'] = $features;
			return $tmp;
		} 
	}
?>