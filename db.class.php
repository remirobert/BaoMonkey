<?php
	/**
	* 
	*/
	class DB
	{
		private $host = 'localhost';
		private $username = 'root';
		private $password = '';
		private $database = 'shop';
		public $db;

		public function __construct($host = null, $username = null, $password = null, $database = null)
		{
			if ($host != null)
				{
					$this->host = $host;
					$this->username = $username;
					$this->password = $password;
					$this->database = $database;
				}
			try{
				$this->db = new PDO('mysql:host='.$this->host.';dbname='.$this->database, $this->username,
					$this->password, array(
						PDO::ATTR_ERRMODE => PDO::ERRMODE_WARNING,
						PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES UTF8'));
			}catch(PDOException $e){
				die('<h1>Impossible de se connecter a la bdd</h1>');
			}
		}

		public function query($sql, $data = array() )
		{
			$req = $this->db->prepare($sql);
			$req->execute($data);
			return $req->fetchAll(PDO::FETCH_OBJ);
		}
	}