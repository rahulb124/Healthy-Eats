//
//  ViewController.swift
//  Nutrition
//
//  Created by Cass Tao on 2/1/19.
//  Copyright © 2019 Cass Tao. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation
import Alamofire
import SwiftyJSON
import CoreXLSX



class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var imagePicker: UIImagePickerController!
    var picSet = false
    var result_bar = ""
    var finalDict: [String: String] = [:]
    var nutJSON : JSON = []
    let Nutritionx_url = "https://trackapi.nutritionix.com/v2/search/item"
    var ingrediant_string = ""
    var name_string = ""
    private var mainArray: NSArray!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "tonextVC"){
            print("try")
            
            if let navigationViewController = segue.destination as? UINavigationController {
                guard let secondVC = navigationViewController.topViewController as? IngredientDetailsViewControllerTableViewController else {return}
                let myDic = finalDict
                let sendName = name_string
                secondVC.name_string = sendName
                secondVC.myDic = myDic
                print("HELLO")
                
                
            }
        }
        
    }
    
    
    
    
    
    let dic : Dictionary = [
        "sodium nitrate":"Added to processed meats to stop bacterial growth. Linked to cancer in humans. (Worst Offender)",
        "sulfites":"Used to keep prepared foods fresh. Can cause breathing difficulties in those sensitive to the ingredient.",
        "azodicarbonamide":"Used in bagels and buns. Can cause asthma.",
        "potassium promate":"Added to breads to increase volume. Linked to cancer in humans.",
        "propyl gallate":"Added to fat-containing products. Linked to cancer in humans",
        "bha/bht":"A fat preservative, used in foods to extend shelf life. Linked to cancerous tumor growth.",
        "propylene glycol":"Better known as antifreeze. Thickens dairy products and salad dressing.",
        "butane":"Put in chicken nuggets to keep them tasting fresh. A known carcinogen.",
        "monosodium glutamate (MSG)":"Flavor enhancer that can cause headaches. Linked in animal studies to nerve damage, heart problems and seizures.",
        "disodium inosinate":"In snack foods. Contains MSG.",
        "disodium guanylate":"Also used in snack foods, and contains MSG.",
        "enriched flour":"Used in many snack foods. A refined starch that is made from toxic ingredients.",
        "recombinant bovine growth hormone":"Genetically-engineered version of natural growth hormone in cows. Boosts milk production in cows.",
        "refined vegetable oil":" High in omega-6 fats, which are thought to cause heart disease and cancer.",
        "soybean oil":"High in omega-6 fats, which are thought to cause heart disease and cancer.",
        "corn oil":"High in omega-6 fats, which are thought to cause heart disease and cancer.",
        "safflower oil":"High in omega-6 fats, which are thought to cause heart disease and cancer.",
        "canola oil":"High in omega-6 fats, which are thought to cause heart disease and cancer.",
        "peanut oil":"High in omega-6 fats, which are thought to cause heart disease and cancer.",
        "sodium benzoate":"Used as a preservative in salad dressing and carbonated beverages. A known carcinogen and may cause damage our DNA.",
        "brominated vegetable oil":"Keeps flavor oils in soft drinks suspended. Bromate is a poison and can cause organ damage and birth defects.",
        "olestra":"Fat-like substance that is unabsorbed by the body. Used in place of natural fats in some snack foods.",
        "carrageenan":"Stabilizer and thickening agent used in many prepared foods. Can cause ulcers and cancer.",
        "polysorbate 60":"A thickener that is used in baked goods. Can cause cancer in laboratory animals.",
        "camauba wax":"Used in chewing gums and to glaze certain foods. Can cause cancer and tumors.",
        "magnesium sulphate":"Used in tofu, and can cause cancer in laboratory animals.",
        "chlorine dioxide":"Used in bleaching flour. Can cause tumors and hyperactivity in children.",
        "paraben":"Used to stop mold and yeast forming in foods. Can disrupt hormones in the body, and could be linked to breast cancer.",
        "sodium carboxymethyl cellulose":"Used as a thickener in salad dressings. Could cause cancer in high quantities.",
        "aluminum":"A preservative in some packaged foods that can cause cancer.",
        "artificial sweeteners":"Regulated by FDA, just as food additives are, but this does not apply to products ‘generally recognized as safe.",
        "saccharin":"Carcinogen found to cause bladder cancer in rats. (Worst Offender)",
        "aspartame":"An excitotoxin and thought to be a carcinogen. Can cause dizziness, headaches, blurred vision and stomach problems.",
        "high fructose corn syrup":"Sweetener made from corn starch. Made from genetically-modified corn. Causes obesity, diabetes, heart problems, arthritis and insulin resistance.",
        "acesulfame potassium":"Used with other artificial sweeteners in diet sodas and ice cream. Linked to lung and breast tumors in rats.",
        "sucralose":"Splenda. Can cause swelling of liver and kidneys and a shrinkage of the thymus gland.",
        "agave nectar":"Sweetener derived from a cactus. Contains high levels of fructose, which causes insulin resistance, liver disease and inflammation of body tissues.",
        "bleached starch":"Can be used in many dairy products. Thought to be related to asthma and skin irritations.",
        "tert butylhydroquinone":"Used to preserve fish products. Could cause stomach tumors at high doses.",
        "food coloring":"Used to give foods a more attractive appearance, but some experts believe they cause serious health problems, including asthma and hyperactivity in children.",
        "red 40":"Found in many foods to alter color. All modern food dyes are derived from petroleum. ",
        "blue 1":"Used in bakery products, candy and soft drinks. Can damage chromosomes and lead to cancer.",
        "blue 2":"Used in candy and pet food beverages. Can cause brain tumors",
        "citrus red 1":"Sprayed on oranges to make them look ripe. Can damage chromosomes and lead to cancer.",
        "citrus red 2":"Used to color oranges. Can cause cancer if you eat the peel.",
        "green 3":"Used in candy and beverages. May cause bladder tumors.",
        "yellow 5":" Used in desserts, candy and baked goods.Thought to cause kidney tumors, according to some studies.",
        "yellow 6":"A carcinogen used in sausage, beverages and baked goods. Thought to cause kidney tumors, according to some studies.",
        "red 2":"A food coloring that may cause both asthma and cancer.",
        "red 3":"A carcinogen. that is added to cherry pie filling, ice cream and baked goods. May cause nerve damage and thyroid cancer.",
        "caramel coloring":"In soft drinks, sauces, pastries and breads. When made with ammonia, it can cause cancer in mice.",
        "brown ht":"Used in many packaged foods. Can cause hyperactivity in children, asthma and cancer.",
        "orange b":"A food dye that is used in hot dog and sausage casings.  High doses are bad for the liver and bile duct.",
        "bixin":"Food coloring that can cause hyperactivity in children and asthma.",
        "norbixin":"Food coloring that can cause hyperactivity in children and asthma.",
        "annatto":"Food coloring that can cause hyperactivity in children and asthma."
    ]
    
    
    @IBOutlet weak var resultsText: UITextView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func takePhoto(_ sender: UIButton) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
        let theButton = sender
        let bounds = theButton.bounds
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
            theButton.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.size.width + 60, height: bounds.size.height)})
        {
            (success:Bool) in
            if success
            {
                theButton.bounds = bounds
            }
        }
    }
    
    func barcodeScan(){
        if (self.picSet == true){
            guard let img = imageView.image else {
                return
            }
            
            //begin config barcode
            let format = VisionBarcodeFormat.all
            let barcodeOptions = VisionBarcodeDetectorOptions(formats: format)
            //end config of barcode
     
            //begin detector creation
            let vision = Vision.vision()
            let barcodeDetector = vision.barcodeDetector(options: barcodeOptions)
            // end detector creation
            
            let ourImage = VisionImage(image: img)
            
            barcodeDetector.detect(in: ourImage) { features, error in
                if let error = error {
                    print(error.localizedDescription)
                    print("gg")
                    return
                }
                
                for barcode in features! {
                    self.result_bar = barcode.displayValue!
                    }
                
                self.NutritionxRequest(barcodeString: self.result_bar, url: self.Nutritionx_url)
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
            imagePicker.dismiss(animated: true, completion: nil)
            imageView.image = info[.originalImage] as? UIImage
            self.picSet = true
            self.barcodeScan()
        }
    func show_harmful()
    {
        
        print("running harmful")
        self.ingrediant_string = String(self.ingrediant_string.dropLast())
        var array = self.ingrediant_string.components(separatedBy: ", ")
        for i in 0..<(array.count - 1)
        {
            array[i] = array[i].lowercased()
        }
        for food_item in array
        {
            for db_item in dic
            {
                if (db_item.key.contains(food_item))
                {
                    self.finalDict[db_item.key] = db_item.value
                }
            }
        }
        
        if finalDict.isEmpty
        {
            self.resultsText.text = String(self.name_string + " is safe to eat!")
        }
        else
        {
            self.resultsText.text = String( "Harmful Ingredients detected in " + self.name_string + ". Press below to learn more.")
        }
        
    }
    
    //HTTP request from NutrionX to get JSON
    func NutritionxRequest(barcodeString: String, url: String)
    {
        var works = false
        let params : [String: String ] = [
            "upc" : barcodeString,
            ]
        let headers: HTTPHeaders = [
            "x-app-id" : "a96c0d61",
            "x-app-key" : "8cdea3900839f16ac78aaafae4ad9ce2",
        ]
        Alamofire.request(url, method: .get, parameters: params,
                          headers: headers).responseJSON
            {
                response in
                if response.result.isSuccess
                {
                    print("Success! Got the boba data")
                    self.nutJSON = JSON(response.result.value!)
                    if (self.nutJSON != nil)
                    {
                        print(self.nutJSON)
                        print(self.nutJSON["foods"][0]["nf_ingredient_statement"])
                        
                        if let ingstring = self.nutJSON["foods"][0]["nf_ingredient_statement"].string {
                            self.ingrediant_string = ingstring
                            works = true
                        }
                    
                        if let namestring = self.nutJSON["foods"][0]["nix_item_name"].string {
                            self.name_string = namestring
                        }
                        else{
                            self.resultsText.text = "Bad Read - Please try again"
                        }
                        if works == true{
                            self.show_harmful()
                        }
                        
                    }
                    else
                    {
                        print("barcode is nil")
                    }
                   
                    
                }
                else
                {
                    self.resultsText.text = "Could not detect barcode"
                }
        }
    }
    func getDic()->String{
        print("printing out finalDict")
        for i in self.finalDict
        {
            print(i.key)
        }
        var a:Dictionary<String,String> = [:]
        print("made new dic")
        a = self.finalDict
        print("getDic function")
        for item in a
        {
            print(item.key)
        }
        print("nice")
        print(self.name_string)
        
        return self.name_string
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed: @"Image.jpeg"]]
    }
}

