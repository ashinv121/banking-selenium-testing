package com.selenium.testing;

import java.io.File;
import java.io.IOException;
import java.util.concurrent.TimeUnit;

import org.apache.commons.io.FileUtils;
import org.openqa.selenium.By;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;


/**
 * Hello world!
 *
 */
public class App 
{
    public static void main( String[] args ) throws InterruptedException, IOException
    {
        System.out.println( "Loading........." );
       //System.setProperty("webdriver.chrome.driver", "C:\\Users\\ashin\\Downloads\\chromedriver-win64\\chromedriver-win64\\chromedriver.exe");
        
      System.setProperty("webdriver.chrome.driver", "/usr/bin/chromedriver");
       
        ChromeOptions chromeOptions = new ChromeOptions();
       ///*
       // chromeOptions.setBinary("/usr/bin/google-chrome");
        chromeOptions.addArguments("--headless");
        chromeOptions.addArguments("--no-sandbox");
        chromeOptions.addArguments("--disable-dev-shm-usage");
        chromeOptions.addArguments("--remote-allow-origins=*");
        //*/
        WebDriver driver = new ChromeDriver(chromeOptions);
        
        driver.get("http://13.53.182.29:8080/create-user.html/");
        driver.manage().timeouts().implicitlyWait(10,TimeUnit.SECONDS);
        driver.findElement(By.id("firstname")).sendKeys("ashin");
        driver.findElement(By.id("lastname")).sendKeys("ashi");
        driver.findElement(By.id("email")).sendKeys("ashin121@gmai.com");
        driver.findElement(By.id("phno")).sendKeys("9497867404");
        driver.findElement(By.id("password")).sendKeys("ashin");
        driver.findElement(By.className("btn-primary")).click();
        
        /*
        driver.findElement(By.cssSelector(".v-button.v-widget")).click();
        driver.findElement(By.id("gwt-uid-5")).sendKeys("ashinv");
        driver.findElement(By.id("gwt-uid-7")).sendKeys("ashinv");
        driver.findElement(By.id("gwt-uid-9")).sendKeys("123456890");
        driver.findElement(By.id("gwt-uid-11")).sendKeys("abz@mail");
        driver.findElement(By.id("gwt-uid-13")).sendKeys("8/10/23,");
        driver.findElement(By.cssSelector(".v-button.v-widget.primary.v-button-primary")).click();
        
        /*
        https://www.facebook.com/
        driver.get("https://www.facebook.com/");
        driver.findElement(By.id("email")).sendKeys("standard_user");
        driver.findElement(By.id("pass")).sendKeys("standard_user");
        driver.findElement(By.id("u_0_5_rp")).click();
       */
        //driver.get("https://www.saucedemo.com/");
        
        
        /*
        driver.findElement(By.id("inputName")).sendKeys("ashiv v");
        driver.findElement(By.id("inputNumber")).sendKeys("949789876");
        driver.findElement(By.id("inputMail")).sendKeys("ashin11222@gmail.com");
        driver.findElement(By.id("inputMessage")).sendKeys("test message");
        driver.findElement(By.id("my-button")).click();
        
        */
        
        //System.out.println(driver.findElement(By.id("response")).getText());
        
       // String confirmationMsg = driver.findElement(By.id("response")).getText();
        //System.out.println(confirmationMsg );
        
        
        /*
        driver.get("https://www.saucedemo.com/");
        
        driver.findElement(By.id("user-name")).sendKeys("standard_user");
        Thread.sleep(3000);
        driver.findElement(By.id("password")).sendKeys("secret_sauce");
        Thread.sleep(3000);
        driver.findElement(By.id("login-button")).click();
        driver.get("https://www.saucedemo.com/inventory.html");
        Thread.sleep(3000);
        driver.findElement(By.id("add-to-cart-sauce-labs-backpack")).click();
        Thread.sleep(3000);
        driver.findElement(By.className("shopping_cart_link")).click();
        driver.findElement(By.id("checkout")).click();
        
        driver.findElement(By.id("first-name")).sendKeys("ashin");
        driver.findElement(By.id("last-name")).sendKeys("valappilkandi");
        driver.findElement(By.id("postal-code")).sendKeys("670678");
        Thread.sleep(3000);
        driver.findElement(By.id("continue")).click();
        driver.findElement(By.id("finish")).click();
        
        System.out.println("Test Passed. your product bookrd sucess.");
        
        
        
        driver.get("https://www.saucedemo.com/");
        
        driver.findElement(By.id("user-name")).sendKeys("standard_user_");
        Thread.sleep(3000);
        driver.findElement(By.id("password")).sendKeys("secret_sauce_");
        Thread.sleep(3000);
        driver.findElement(By.id("login-button")).click();
        Thread.sleep(2000);

 
        WebElement errorMessageContainer = driver.findElement(By.cssSelector("div.error-message-container.error"));
        if (errorMessageContainer.isDisplayed()) {
            System.out.println("Test Passed. Error message container displayed.");
        } else {
            System.out.println("Test Failed. Error message container not displayed.");
        }
        
 */
        
    
            
        
          Thread.sleep(3000);
   
		  TakesScreenshot scrShot = ((TakesScreenshot)driver);
		  File screenShot = scrShot.getScreenshotAs(OutputType.FILE);
		  File destFile = new File("screenshot.png");
		  FileUtils.copyFile(screenShot, destFile);
		  System.out.println("reports stored at : " + destFile.getAbsolutePath().toString());
		  driver.quit();
		  System.out.println( "program end" );
        
        
        //TakesScreenshot scrShot =((TakesScreenshot)driver);
      
       
  }
    
    
}
