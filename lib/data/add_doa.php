try {
    	if (isset($_POST["Full_Name"]) ) {
    		$Full_Name = $_POST["Full_Name"];
    		$Gender = $_POST["Gender"];
			$Born_Place = $_POST["Born_Place"];
			$Born_Date = $_POST["Born_Date"];
            $Father_Name = $_POST["Father_Name"];
            $Mother_Name =$_POST["Mother_Name"];
            $Address = $_POST["Address"];
			$Phone_Number = $_POST["Phone_Number"];
			$Home_Phone_Number = $_POST["Home_Phone_Number"];
			$Church_Name = $_POST["Church_Name"];
            
            
    		
    		require_once("db_connect.php");
    		$result = $con->prepare(
        		"SELECT Full_Name 
        		    FROM Baptism
        		    WHERE Full_Name = ?"
        	);
        	$result->execute([$Full_Name]);
        	if (($row = $result->fetch(PDO::FETCH_ASSOC)) !== false) {
        		$response["success"] = 0;
        	    $response["message"] = "Anda sudah terdaftar !";
        	} else {
        		$result = $con->prepare(
    				"INSERT INTO Baptism(Full_Name, Gender, Born_Date, Born_Place, Father_Name, Mother_Name, Address, Phone_Number, Home_Phone_Number, Church_Name) 
    					VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
    			);
    			if ($result->execute([$Full_Name, $Gender, $Born_Date, $Born_Place, $Father_Name, $Mother_Name, $Address, $Phone_Number, $Home_Phone_Number, $Church_Name])) {
    				$response["success"] = 1;
        	        $response["message"] = "Success.";
    			}
        	}
    	} else {
        	$response["success"] = 0;
        	$response["message"] = "Error.";
    	}
    } catch (PDOException $e) {
    	$response["success"] = 0;
    	$response["message"] = "Error.1";
    }